Pry.config.theme='wombat'

if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

if defined?(BigDecimal)
  BigDecimal.class_eval do
    def inspect
      "BigDecimal(#{to_s})"
    end
  end
end

if defined?(Rails) && Rails.env
  extend Rails::ConsoleMethods
end

