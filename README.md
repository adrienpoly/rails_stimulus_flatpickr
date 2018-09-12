# Rails Showcase of Stimulus-Flatpickr wrapper

This project is in support of the article I published on dev.to
https://dev.to/adrienpoly/introducing-stimulus-flatpickr-wrapper--5c23

This example shows how to use [stimulus-flatpickr](https://github.com/adrienpoly/stimulus-flatpickr) wrapper in a Rails app to have an advanced date picking solution with:

* localization of the datepicker 🌍
* localization of the date formats 🌍
* availabilities in the date picker 📅
* Fully boosted with Turbolinks 🚀

![rails stimulus flatpickr demo](./app/assets/images/rails-stimulus-flatpickr-demo.gif)

## What does it takes to make this app

The date picker field

```erb
<%= form_with model: appointment do |f| %>
  <%= f.text_field :start_at,
      placeholder: t(".select"),
      data: {
        controller: "flatpickr",
        flatpickr_alt_format: t("date.formats.long"),
        flatpickr_alt_input: true,
        flatpickr_default_date: appointment.start_at,
        flatpickr_locale: locale,
        flatpickr_show_months: 2,
        flatpickr_min_date: Time.zone.now,
        flatpickr_max_date: Time.zone.now + 60.days,
        flatpickr_disable: Appointment.up_comings(60).pluck(:start_at) - [appointment.start_at],
      } %>
<% end %>
```

and the stimulus controller

```javascript
import Flatpickr from "stimulus-flatpickr";
import Rails from "rails-ujs";

// import a theme (could be in your main CSS entry too...)
import "flatpickr/dist/themes/dark.css";

// import the translation files and create a translation mapping
import { French } from "flatpickr/dist/l10n/fr.js";
import { english } from "flatpickr/dist/l10n/default.js";

// create a new Stimulus controller by extending stimulus-flatpickr wrapper controller
export default class extends Flatpickr {
  locales = {
    fr: French,
    en: english
  };

  connect() {
    //define locale and global flatpickr settings for all datepickers
    this.config = {
      locale: this.locale,
      altInput: true,
      showMonths: 2
    };

    super.connect();
  }

  // automatically submit form when a date is selected
  change(selectedDates, dateStr, instance) {
    const form = this.element.closest("form");
    Rails.fire(form, "submit");
  }

  get locale() {
    if (this.locales && this.data.has("locale")) {
      return this.locales[this.data.get("locale")];
    } else {
      return "";
    }
  }
}
```
