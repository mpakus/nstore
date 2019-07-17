# frozen_string_literal: true

require 'nstore/version'

# Mixin module to include into your class
# @example
#   class YourClass
#     include NStore
#
#     attr_accessor :meta
#
#     nstore :meta,
#            accessors: {
#                jira: {
#                    board: [:id, :name, user: %i[id name]]
#                },
#                trello: %i[id name]
#            },
#            prefix:       false,
#            stringify:    true
#     ...
module NStore
  class Error < StandardError; end

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  # List of Class methods going to be included above
  module ClassMethods
    def nstore(attribute, options)
      accessors    = options[:accessors]
      prefix       = options.fetch(:prefix, false)
      stringify    = options.fetch(:stringify, true)

      flat_accessors = []
      deep_flatten(accessors, [], flat_accessors)
      attribute = attribute.to_s if stringify
      _nstore_generate_accessors(attribute, flat_accessors, prefix, stringify)
    end

    def _nstore_generate_accessors(attribute, flat_accessors, prefix, stringify)
      flat_accessors.each do |keys|
        keys.map!(&:to_s) if stringify

        define_method("#{prefix ? "#{attribute}_" : ''}#{keys.join('_')}=".to_sym) do |value|
          write_nstore_attribute(attribute, keys, value)
        end

        define_method("#{prefix ? "#{attribute}_" : ''}#{keys.join('_')}".to_sym) do
          read_nstore_attribute(attribute, keys)
        end
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

  # @param [Symbol,String] attribute
  # @param [Array<String,Symbol>] keys
  # @param [Object] value
  def write_nstore_attribute(attribute, keys, value)
    send("#{attribute}=", {}) if send(attribute).nil?
    position = send(attribute)

    keys[0..-2].each do |key|
      position[key] = {} unless position[key].is_a? Hash
      position      = position[key]
    end
    position[keys[-1]] = value
  end

  # @param [Symbol,String] attribute
  # @param [Array<String,Symbol>] keys
  # @return [Object]
  def read_nstore_attribute(attribute, keys)
    send(attribute).send(:dig, *keys)
  end
end
