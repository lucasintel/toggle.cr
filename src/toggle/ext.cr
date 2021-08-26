module Toggle
  annotation RequireInstance
  end

  macro finished
    {% for method in @type.methods %}
      {% if method.annotation(RequireInstance) %}
        {% if method.return_type %}
          def {{method.name}}({{method.args.join(", ").id}}) : {{method.return_type}}
        {% else %}
          def {{method.name}}({{method.args.join(", ").id}})
        {% end %}
          raise Toggle::NotInitializedError.new if {{method.args.last.name.id}}.nil?
          {{method.body}}
        end
      {% end %}
    {% end %}
  end
end
