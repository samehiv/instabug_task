module V1
  class Pagination
    def self.serialize(data, page = 1, per_page = 15)
      page = (page || 1).to_i
      per_page = (per_page || 15).to_i
      paginated = data.page(page).per(per_page)

      if data.is_a?(Elasticsearch::Model::Response::Response)
        paginated = paginated.records
      end

      serialization(paginated)
    end

    def self.serialization(paginated)
      OpenStruct.new(
        items: paginated,
        pagination: { total_pages: paginated.total_pages,
                      total_items: paginated.total_count,
                      current_page: paginated.current_page,
                      first_page: paginated.first_page?,
                      last_page: paginated.last_page?,
                      next_page: paginated.next_page,
                      prev_page: paginated.prev_page }
      )
    end
  end
end
