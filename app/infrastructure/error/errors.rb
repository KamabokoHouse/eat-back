class Errors < ::StandardError
    def initialize(status: nil, detail: nil)
        @status = status || 500
        @detail = detail || "We encountered unexpected error, but our developers had been already notified about it"
    end

    attr_reader :status, :detail
end
