module Host::ListingsHelper
  def listing_fields
    {
      title:         'text',
      about:         'textarea',
      max_guests:    'number',
      address_line1: 'text',
      address_line2: 'text',
      city:          'text',
      state:         'text',
      postal_code:   'text',
      country:       'text'
    }
  end
end
