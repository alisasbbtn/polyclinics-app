import Rails from '@rails/ujs';

document.body.querySelector('.category-select').addEventListener('change', function (event) {
    let myData = {
        category_id: event.target.value
    };

    Rails.ajax({
        type: 'GET',
        url: '/doctors',
        data: new URLSearchParams(myData).toString()
    });
});