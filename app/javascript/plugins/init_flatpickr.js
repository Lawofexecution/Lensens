import flatpickr from 'flatpickr';
import { French } from "flatpickr/dist/l10n/fr.js";

const initFlatpickr = function () {
  const startDateInput = document.getElementById('booking_start_date');
  const endDateInput = document.getElementById('booking_end_date');
  if (startDateInput && endDateInput) {
    const unvailableDates = JSON.parse(document.querySelector('.widget-content').dataset.unavailable)

    flatpickr(startDateInput, {
      minDate: 'today',
      dateFormat: 'd-m-Y H:i',
      enableTime: true,
      locale: French,
      disable: unvailableDates,
      onChange: function (selectedDates, selectedDate) {
        if (selectedDate === '') {
          endDateInput.disabled = true;
        }
        let minDate = selectedDates[0];
        minDate.setDate(minDate.getDate());
        endDateCalendar.set('minDate', minDate);
        endDateInput.disabled = false;
      }
    });

    const endDateCalendar =
      flatpickr(endDateInput, {
        dateFormat: 'd-m-Y H:i',
        enableTime: true,
        locale: French,
        disable: unvailableDates,
      });
  }
};

export { initFlatpickr }
