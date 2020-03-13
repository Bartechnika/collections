module SupergroupSections
  class Sections
    attr_reader :taxon_id, :base_path

    def initialize(taxon_id, base_path)
      @taxon_id = taxon_id
      @base_path = base_path
    end

    def sections
      SUPERGROUPS.map do |supergroup|
        {
          id: supergroup.name,
          title: supergroup.title,
          promoted_content: (supergroup.promoted_content(taxon_id, supergroup.title) if supergroup.methods.include? :promoted_content),
          documents: supergroup.document_list(taxon_id, supergroup.title),
          partial_template: supergroup.partial_template,
          see_more_link: supergroup.finder_link(base_path, taxon_id),
          show_section: supergroup.show_section?(taxon_id),
        }
      end
    end
  end
end
