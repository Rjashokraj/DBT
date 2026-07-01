{%- set apples = ['Fuji', 'Gala', 'Honeycrisp'] -%}

{% for i in apples %}
  {%if i != 'Gala' %}
    {{i}}
  {%else%}
    {{i}} is not a good apple
  {%endif%}
{% endfor %}