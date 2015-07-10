require 'spec_helper'

describe GraphQL::SchemaType do
  let(:query_string) {%|
    query getSchema {
      __schema {
        types { name }
        queryType { fields { name }}
      }
    }
  |}
  let(:result) { GraphQL::Query.new(DummySchema, query_string).execute }
  it 'exposes the schema' do
    expected = { "getSchema" => {
      "__schema" => {
        "types" => DummySchema.types.values.map { |t| t.name.nil? ? (p t; raise("no name for #{t}")) : {"name" => t.name} },
        "queryType"=>{
          "fields"=>[
            {"name"=>"cheese"},
            {"name"=>"fromSource"},
            {"name"=>"favoriteEdible"},
            {"name"=>"searchDairy"},
            {"name"=>"__type"},
            {"name"=>"__schema"}
          ]
        }
      }
    }}
    assert_equal(expected, result)
  end
end
