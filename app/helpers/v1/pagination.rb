module V1
  class Pagination
    def self.serialize(relation, page = 1, per_page = 15)
      page = (page || 1).to_i
      per_page = (per_page || 15).to_i
      pagination = relation.page(page).per(per_page)

      OpenStruct.new(
        items: pagination,
        pagination: { per_page: per_page,
                      total_pages: pagination.total_pages,
                      total_items: pagination.total_count,
                      current_page: pagination.current_page,
                      first_page: pagination.first_page?,
                      last_page: pagination.last_page?,
                      next_page: pagination.next_page,
                      prev_page: pagination.prev_page }
      )
    end
  end
end
