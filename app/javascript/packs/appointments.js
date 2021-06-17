import Rails from '@rails/ujs';

let form = document.body.querySelector('.appointment-form');
form.querySelector('input[type=date]').addEventListener('change', function (event) {

    let id = form.dataset.doctorId;

    let myData = {
        date: form.querySelector('input[type=date]').value
    };

    Rails.ajax({
        type: 'GET',
        url: `/doctors/${id}/appointments/available_hours`,
        data: new URLSearchParams(myData).toString()
    });
});