require "test_helper"

describe Topic do
  setup do
    @api_data = {
      "base_path" => "/topic/business-tax/paye",
      "title" => "PAYE",
      "description" => "Pay As You Earn",
      "details" => {
      },
      "links" => {
        "parent" => [{
          "title"=>"Business tax",
          "base_path"=>"/topic/business-tax",
          "description"=>"All about tax for businesses",
        }],
      },
    }
    @topic = Topic.new(@api_data)
  end

  describe "basic properties" do
    it "returns the topic base_path" do
      assert_equal "/topic/business-tax/paye", @topic.base_path
    end

    it "returns the topic title" do
      assert_equal "PAYE", @topic.title
    end

    it "returns the topic description" do
      assert_equal "Pay As You Earn", @topic.description
    end

    it "returns the topic's beta status" do
      assert_equal false, @topic.beta?

      @api_data["details"]["beta"] = true
      assert_equal true, @topic.beta?
    end
  end

  describe "parent" do
    it "returns the parent title" do
      assert_equal "Business tax", @topic.parent.title
    end

    it "returns the parent base_path" do
      assert_equal "/topic/business-tax", @topic.parent.base_path
    end

    it "returns the combined_title" do
      assert_equal "Business tax: PAYE", @topic.combined_title
    end

    describe "when parent details are missing" do
      # This should never happen, but it's still good to make this defensive
      setup do
        @api_data["links"].delete("parent")
      end

      it "returns nil for parent" do
        assert_nil @topic.parent
      end

      it "returns the topic title in combined_title" do
        assert_equal "PAYE", @topic.combined_title
      end

      it "handles the links hash missing completely" do
        @api_data.delete("links")
        assert_nil @topic.parent
      end
    end
  end

  describe "children" do
    it "returns the title and base_path for all children" do
      @api_data["links"]["children"] = [
        {
          "title"=>"Foo",
          "base_path"=>"/topic/business-tax/foo",
        },
        {
          "title"=>"Bar",
          "base_path"=>"/topic/business-tax/bar",
        },
      ]

      assert_equal 'Foo', @topic.children[0].title
      assert_equal '/topic/business-tax/bar', @topic.children[1].base_path
    end

    it "returns empty array with no children" do
      assert_equal [], @topic.children
    end

    it "returns empty array when the links field is missing" do
      @api_data.delete("links")
      assert_equal [], @topic.children
    end
  end

  describe "slug" do
    it "returns the slug for a topic at the root of the namespace" do
      @api_data["base_path"] = "/business-tax/paye"
      assert_equal "business-tax/paye", @topic.slug
    end

    it "returns the slug for a topic under the /topic namespace" do
      @api_data["base_path"] = "/topic/business-tax/paye"
      assert_equal "business-tax/paye", @topic.slug
    end
  end

  describe "groups" do
    it "should pass the contentapi slug of the topic when constructing groups" do
      Topic::Groups.expects(:new).with("business-tax/paye", anything()).returns(:a_groups_instance)

      assert_equal :a_groups_instance, @topic.groups
    end

    it "should pass the groups data when constructing" do
      Topic::Groups.expects(:new).with(anything(), :some_data).returns(:a_groups_instance)
      @api_data["details"]["groups"] = :some_data

      assert_equal :a_groups_instance, @topic.groups
    end
  end

  describe "changed_documents" do
    setup do
      @topic = Topic.new(@api_data, {:foo => "bar"})
    end

    it "should pass the contentapi slug of the topic when constructing changed_documents" do
      Topic::ChangedDocuments.expects(:new).with("business-tax/paye", anything()).returns(:an_instance)
      assert_equal :an_instance, @topic.changed_documents
    end

    it "should pass the pagination options when constructing changed_documents" do
      Topic::ChangedDocuments.expects(:new).with(anything(), :foo => "bar").returns(:an_instance)
      assert_equal :an_instance, @topic.changed_documents
    end
  end
end
