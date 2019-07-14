# frozen_string_literal: true

require 'nstore/version'

module NStore
  class Error < StandardError; end

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods

    def nstore(attribute, options)
      prefix    = options.fetch(:prefix, false)
      accessors = options[:accessors]
      _accessors = []
      deep_flatten(accessors, [], _accessors)

      _accessors.each do |keys|
        define_method("#{prefix ? "#{attribute}_" : ''}#{keys.join('_')}=".to_sym) do |value|
          write_nstore_attribute(attribute, keys, value)
        end

        define_method("#{prefix ? "#{attribute}_" : ''}#{keys.join('_')}".to_sym) do
          read_nstore_attribute(attribute, keys)
        end
      end
    end

    def _store_accessors_module # :nodoc: ActiveRecord::Store
      @_store_accessors_module ||= begin
        mod = Module.new
        include mod
        mod
      end
    end

    private

    def deep_flatten(tree, path, result)
      tree.each do |key, value|
        _array_wrap(value).each do |e|
          if e.is_a? Hash
            deep_flatten(e, path + [key], result)
          else
            result << path + [key, e]
          end
        end
      end
    end

    # @return [Array]
    def _array_wrap(object)
      if object.nil?
        []
      elsif object.respond_to?(:to_ary)
        object.to_ary || [object]
      else
        [object]
      end
    end
  end

  private

  # @param [Symbol] attribute
  # @param [Array] keys
  # @param [Object] value
  def write_nstore_attribute(attribute, keys, value)
    position = self.send(attribute)
    keys.map(&:to_s)[0..-2].each do |key|
      position[key] = {} unless position[key].is_a?(Hash)
      position      = position[key]
    end
    position[keys[-1].to_s] = value
  end

  def read_nstore_attribute(attribute, keys)
    self.send(attribute).send(:dig, *keys.map{ |s| s.to_s })
  end
end
