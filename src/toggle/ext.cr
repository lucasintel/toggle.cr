module Toggle
  annotation RequireInstance
  end

  macro finished
    {% for method in @type.methods %}
      {% if method.annotation(RequireInstance) %}
        def {{method.name}}({{method.args.join(", ").id}}) {% if method.return_type %} : {{method.return_type}} {% end %}
          raise Toggle::NotInitializedError.new if instance.nil?
          {{method.body}}
        end
      {% end %}
    {% end %}
  end
end
