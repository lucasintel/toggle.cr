module Toggle
  macro delegate_to_instance(*methods, to object = Toggle.current)
    {% for method in methods %}
      {% if method.id.ends_with?('=') && method.id != "[]=" %}
        def self.{{method.id}}(arg)
          if instance = self.{{object.id}}
            instance.{{method.id}} arg
          else
            raise NotInitializedError.new
          end
        end
      {% else %}
        def self.{{method.id}}(*args, **options)
          if instance = self.{{object.id}}
            instance.{{method.id}}(*args, **options)
          else
            raise NotInitializedError.new
          end
        end

        {% if method.id != "[]=" %}
          def self.{{method.id}}(*args, **options)
            if instance = self.{{object.id}}
              instance.{{method.id}}(*args, **options) do |*yield_args|
                yield *yield_args
              end
            else
              raise NotInitializedError.new
            end
          end
        {% end %}
      {% end %}
    {% end %}
  end
end
