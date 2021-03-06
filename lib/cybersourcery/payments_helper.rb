module Cybersourcery
  module PaymentsHelper
    def add_signed_fields(payment, form)
      signed_fields = ''

      payment.signed_fields.each do |field, value|
        signed_fields << hidden_input(form, field, value)
      end

      signed_fields
    end

    def simple_form_input(form, field, value = nil)
      form.input field, label: field_label(field), input_html: {
        name: field.to_s,
        value: value,
        pattern: field_pattern(field),
        title: field_validation_message(field)
      }
    end

    def simple_form_select(form, field, collection, selected = nil, prompt = nil)
      form.input(
        field,
        label: field_label(field),
        collection: collection,
        selected: selected,
        prompt: prompt,
        input_html: { name: field.to_s }
      )
    end

    def field_label(field)
      labels = {
        bill_to_forename: 'First Name',
        bill_to_surname: 'Last Name',
        card_number: 'Card Number',
        card_cvn: 'Security Code',
        card_expiry_dummy: 'Expiration',
        bill_to_email: 'Email',
        bill_to_address_line1: 'Street Address (line 1)',
        bill_to_address_line2: 'Street Address (line 2)',
        bill_to_address_city: 'City',
        bill_to_address_state: 'State (Province)',
        bill_to_address_postal_code: 'Zip (Postal Code)'
      }
      labels[field]
    end

    def field_pattern(field)
      patterns = {
        card_number: "^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$"
      }
      patterns[field]
    end

    def field_validation_message(field)
      patterns = {
        card_number: 'Please enter a valid credit card number'
      }
      patterns[field]
    end

    def hidden_input(form, field, value = nil)
      form.hidden_field field, value: value, name: field.to_s
    end

    def add_expiry_date_fields(form, classes = 'select required form-control card-expiry')
      date_fields =  hidden_input form, :card_expiry_date
      date_fields << form.input(:card_expiry_dummy, label: field_label(:card_expiry_dummy)) do
        form.date_select(:card_expiry_dummy,
          {
            discard_day: true,
            order: [:month, :year],
            start_year: Date.today.year,
            end_year:  (Date.today.year + 19),
            use_two_digit_numbers: true,
            date_separator: ' / ',
            prompt: true
          },
          { class: classes }
        )
      end
    end

    def countries
      {
        "Afghanistan" => "AF",
        "Aland Islands" => "AX",
        "Albania" => "AL",
        "Algeria" => "DZ",
        "American Samoa (US)" => "AS",
        "Andorra" => "AD",
        "Angola" => "AO",
        "Anguilla (UK)" => "AI",
        "Antarctica" => "AQ",
        "Antigua and Barbuda" => "AG",
        "Argentina" => "AR",
        "Armenia" => "AM",
        "Aruba" => "AW",
        "Australia" => "AU",
        "Austria" => "AT",
        "Azerbaijan" => "AZ",
        "Bahamas" => "BS",
        "Bahrain" => "BH",
        "Bangladesh" => "BD",
        "Barbados" => "BB",
        "Belarus" => "BY",
        "Belgium" => "BE",
        "Belize" => "BZ",
        "Benin" => "BJ",
        "Bermuda (UK)" => "BM",
        "Bhutan" => "BT",
        "Bolivia" => "BO",
        "Bonaire, Sint Eustatius and Saba" => "BQ",
        "Bosnia and Herzegovina" => "BA",
        "Botswana" => "BW",
        "Brazil" => "BR",
        "British Indian Ocean Territory" => "IO",
        "British Virgin Islands (UK)" => "VG",
        "Brunei Darussalam" => "BN",
        "Bulgaria" => "BG",
        "Burkina Faso" => "BF",
        "Burundi" => "BI",
        "Cambodia" => "KH",
        "Cameroon" => "CM",
        "Canada" => "CA",
        "Cape Verde" => "CV",
        "Cayman Islands (UK)" => "KY",
        "Central African Republic" => "CF",
        "Chad" => "TD",
        "Chile" => "CL",
        "China" => "CN",
        "Christmas Island (AU)" => "CX",
        "Cocos (Keeling) Islands (AU)" => "CC",
        "Colombia" => "CO",
        "Comoros" => "KM",
        "Congo, Democratic Republic of the" => "CD",
        "Congo, Republic of the" => "CG",
        "Cook Islands (NZ)" => "CK",
        "Costa Rica" => "CR",
        "Côte D'Ivoire" => "CI",
        "Croatia" => "HR",
        "Cuba" => "CU",
        "Curaçao" => "CW",
        "Cyprus" => "CY",
        "Czech Republic" => "CZ",
        "Denmark" => "DK",
        "Djibouti" => "DJ",
        "Dominica" => "DM",
        "Dominican Republic" => "DO",
        "Ecuador" => "EC",
        "Egypt" => "EG",
        "El Salvador" => "SV",
        "Equatorial Guinea" => "GQ",
        "Eritrea" => "ER",
        "Estonia" => "EE",
        "Ethiopia" => "ET",
        "Falkland Islands (UK)" => "FK",
        "Faroe Islands (DK)" => "FO",
        "Fiji" => "FJ",
        "Finland" => "FI",
        "France" => "FR",
        "French Guiana (FR)" => "GF",
        "French Polynesia (FR)" => "PF",
        "French Southern Territories" => "TF",
        "Gabon" => "GA",
        "Gambia" => "GM",
        "Georgia" => "GE",
        "Germany" => "DE",
        "Ghana" => "GH",
        "Gibraltar (UK)" => "GI",
        "Greece" => "GR",
        "Greenland (DK)" => "GL",
        "Grenada" => "GD",
        "Guadeloupe (FR)" => "GP",
        "Guam (US)" => "GU",
        "Guatemala" => "GT",
        "Guernsey" => "GG",
        "Guinea" => "GN",
        "Guinea-Bissau" => "GW",
        "Guyana" => "GY",
        "Haiti" => "HT",
        "Heard Island and McDonald Islands" => "HM",
        "Holy See (Vatican City)" => "VA",
        "Honduras" => "HN",
        "Hong Kong (CN)" => "HK",
        "Hungary" => "HU",
        "Iceland" => "IS",
        "India" => "IN",
        "Indonesia" => "ID",
        "Iran" => "IR",
        "Iraq" => "IQ",
        "Ireland" => "IE",
        "Isle of Man" => "IM",
        "Israel" => "IL",
        "Italy" => "IT",
        "Jamaica" => "JM",
        "Japan" => "JP",
        "Jersey" => "JE",
        "Jordan" => "JO",
        "Kazakhstan" => "KZ",
        "Kenya" => "KE",
        "Kiribati" => "KI",
        "Korea, Democratic People's Republic (North)" => "KP",
        "Korea, Republic of (South)" => "KR",
        "Kuwait" => "KW",
        "Kyrgyzstan" => "KG",
        "Laos" => "LA",
        "Latvia" => "LV",
        "Lebanon" => "LB",
        "Lesotho" => "LS",
        "Liberia" => "LR",
        "Libya" => "LY",
        "Liechtenstein" => "LI",
        "Lithuania" => "LT",
        "Luxembourg" => "LU",
        "Macau (CN)" => "MO",
        "Macedonia" => "MK",
        "Madagascar" => "MG",
        "Malawi" => "MW",
        "Malaysia" => "MY",
        "Maldives" => "MV",
        "Mali" => "ML",
        "Malta" => "MT",
        "Marshall Islands" => "MH",
        "Martinique (FR)" => "MQ",
        "Mauritania" => "MR",
        "Mauritius" => "MU",
        "Mayotte (FR)" => "YT",
        "Mexico" => "MX",
        "Micronesia, Federated States of" => "FM",
        "Moldova Republic of" => "MD",
        "Monaco" => "MC",
        "Mongolia" => "MN",
        "Montenegro" => "ME",
        "Montserrat (UK)" => "MS",
        "Morocco" => "MA",
        "Mozambique" => "MZ",
        "Myanmar" => "MM",
        "Namibia" => "NA",
        "Nauru" => "NR",
        "Nepal" => "NP",
        "Netherlands" => "NL",
        "Netherlands Antilles (NL)" => "AN",
        "New Caledonia (FR)" => "NC",
        "New Zealand" => "NZ",
        "Nicaragua" => "NI",
        "Niger" => "NE",
        "Nigeria" => "NG",
        "Niue" => "NU",
        "Norfolk Island (AU)" => "NF",
        "Northern Mariana Islands (US)" => "MP",
        "Norway" => "NO",
        "Oman" => "OM",
        "Pakistan" => "PK",
        "Palau" => "PW",
        "Palestinian Territories" => "PS",
        "Panama" => "PA",
        "Papua New Guinea" => "PG",
        "Paraguay" => "PY",
        "Peru" => "PE",
        "Philippines" => "PH",
        "Pitcairn Islands (UK)" => "PN",
        "Poland" => "PL",
        "Portugal" => "PT",
        "Puerto Rico (US)" => "PR",
        "Qatar" => "QA",
        "Reunion (FR)" => "RE",
        "Romania" => "RO",
        "Russia" => "RU",
        "Rwanda" => "RW",
        "Saint Barthelemy" => "BL",
        "Saint Helena (UK)" => "SH",
        "Saint Kitts and Nevis" => "KN",
        "Saint Lucia" => "LC",
        "Saint Martin" => "MF",
        "Saint Pierre & Miquelon (FR)" => "PM",
        "Saint Vincent and the Grenadines" => "VC",
        "Samoa" => "WS",
        "San Marino" => "SM",
        "Sao Tome and Principe" => "ST",
        "Saudi Arabia" => "SA",
        "Senegal" => "SN",
        "Serbia" => "RS",
        "Seychelles" => "SC",
        "Sierra Leone" => "SL",
        "Singapore" => "SG",
        "Sint Maarten (Dutch Part)" => "SX",
        "Slovakia" => "SK",
        "Slovenia" => "SI",
        "Solomon Islands" => "SB",
        "Somalia" => "SO",
        "South Africa" => "ZA",
        "South Georgia & South Sandwich Islands (UK)" => "GS",
        "South Sudan" => "SS",
        "Spain" => "ES",
        "Sri Lanka" => "LK",
        "Sudan" => "SD",
        "Suriname" => "SR",
        "Svalbard and Jan Mayen" => "SJ",
        "Swaziland" => "SZ",
        "Sweden" => "SE",
        "Switzerland" => "CH",
        "Syria" => "SY",
        "Taiwan" => "TW",
        "Tajikistan" => "TJ",
        "Tanzania" => "TZ",
        "Thailand" => "TH",
        "Timor-Leste" => "TL",
        "Togo" => "TG",
        "Tokelau" => "TK",
        "Tonga" => "TO",
        "Trinidad and Tobago" => "TT",
        "Tunisia" => "TN",
        "Turkey" => "TR",
        "Turkmenistan" => "TM",
        "Turks and Caicos Islands (UK)" => "TC",
        "Tuvalu" => "TV",
        "Uganda" => "UG",
        "Ukraine" => "UA",
        "United Arab Emirates" => "AE",
        "United Kingdom" => "GB",
        "United States" => "US",
        "United States Minor Outlying Islands" => "UM",
        "Uruguay" => "UY",
        "Uzbekistan" => "UZ",
        "Vanuatu" => "VU",
        "Venezuela" => "VE",
        "Vietnam" => "VN",
        "Virgin Islands (US)" => "VI",
        "Wallis and Futuna (FR)" => "WF",
        "Western Sahara" => "EH",
        "Yemen" => "YE",
        "Zambia" => "ZM",
        "Zimbabwe" => "ZW"
      }
    end

    def us_states
      {
        "Alabama" => "AL",
        "Alaska" => "AK",
        "Arizona" => "AZ",
        "Arkansas" => "AR",
        "California" => "CA",
        "Colorado" => "CO",
        "Connecticut" => "CT",
        "Delaware" => "DE",
        "Florida" => "FL",
        "Georgia" => "GA",
        "Hawaii" => "HI",
        "Idaho" => "ID",
        "Illinois" => "IL",
        "Indiana" => "IN",
        "Iowa" => "IA",
        "Kansas" => "KS",
        "Kentucky" => "KY",
        "Louisiana" => "LA",
        "Maine" => "ME",
        "Maryland" => "MD",
        "Massachusetts" => "MA",
        "Michigan" => "MI",
        "Minnesota" => "MN",
        "Mississippi" => "MS",
        "Missouri" => "MO",
        "Montana" => "MT",
        "Nebraska" => "NE",
        "Nevada" => "NV",
        "New Hampshire" => "NH",
        "New Jersey" => "NJ",
        "New Mexico" => "NM",
        "New York" => "NY",
        "North Carolina" => "NC",
        "North Dakota" => "ND",
        "Ohio" => "OH",
        "Oklahoma" => "OK",
        "Oregon" => "OR",
        "Pennsylvania" => "PA",
        "Rhode Island" => "RI",
        "South Carolina" => "SC",
        "South Dakota" => "SD",
        "Tennessee" => "TN",
        "Texas" => "TX",
        "Utah" => "UT",
        "Vermont" => "VT",
        "Virginia" => "VA",
        "Washington" => "WA",
        "West Virginia" => "WV",
        "Wisconsin" => "WI",
        "Wyoming" => "WY"
      }
    end

    def card_types
      {
        'Visa' => '001',
        'MasterCard' => '002',
        'American Express' => '003',
        'Discover' => '004'
      }
    end
  end
end
