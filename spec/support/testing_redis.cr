require "redis"

module TestingRedis
  TEST_DB = 10

  class_property current : Redis { Redis.new(database: TEST_DB) }
end
