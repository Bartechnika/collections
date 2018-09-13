require 'test_helper'

describe Supergroups::GuidanceAndRegulation do
  include RummagerHelpers

  let(:taxon_id) { '12345' }
  let(:guidance_and_regulation_supergroup) { Supergroups::GuidanceAndRegulation.new }

  describe '#document_list' do
    it 'returns a document list for the guidance and regulation supergroup' do
      MostPopularContent.any_instance
        .stubs(:fetch)
        .returns(section_tagged_content_list('guidance', 4))

      expected = [
        {
          link: {
            text: 'Tagged Content Title',
            path: '/government/tagged/content',
            data_attributes: {
              track_category: "guidanceAndRegulationDocumentListClicked",
              track_action: 1,
              track_label: '/government/tagged/content',
              track_options: {
                dimension29: 'Tagged Content Title'
              }
            }
          },
          metadata: {
            public_updated_at: Time.parse('2018-02-28T08:01:00.000+00:00'),
            organisations: 'Tagged Content Organisation',
            document_type: 'Guidance'
          }
        }
      ]

      assert_equal expected, guidance_and_regulation_supergroup.document_list(taxon_id)
    end

    it 'return a document list for guides' do
      MostPopularContent.any_instance
        .stubs(:fetch)
        .returns(section_tagged_content_list('guide', 4))

      expected = [
        {
          link: {
            text: 'Tagged Content Title',
            path: '/government/tagged/content',
            description: 'Description of tagged content',
            data_attributes: {
              track_category: "guidanceAndRegulationDocumentListClicked",
              track_action: 1,
              track_label: '/government/tagged/content',
              track_options: {
                dimension29: 'Tagged Content Title'
              }

            }
          },
          metadata: {
            document_type: 'Guide'
          }
        }
      ]

      actual = guidance_and_regulation_supergroup.document_list(taxon_id)

      assert_equal expected, actual
      assert_equal 1, actual.count
    end
  end

  describe '#promoted_content' do
    it 'returns promoted content for the guidance and regulation supergroup' do
      MostPopularContent.any_instance
        .stubs(:fetch)
        .returns(section_tagged_content_list('guidance'))

      expected = [
        {
          link: {
            text: 'Tagged Content Title',
            path: '/government/tagged/content',
            data_attributes: {
              track_category: "guidanceAndRegulationHighlightBoxClicked",
              track_action: 1,
              track_label: '/government/tagged/content',
              track_options: {
                dimension29: 'Tagged Content Title'
              }
            }
          },
          metadata: {
            public_updated_at: Time.parse('2018-02-28T08:01:00.000+00:00'),
            organisations: 'Tagged Content Organisation',
            document_type: 'Guidance'
          }
        }
      ]

      assert_equal expected, guidance_and_regulation_supergroup.promoted_content(taxon_id)
    end
  end
end
