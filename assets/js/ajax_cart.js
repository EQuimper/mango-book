function ajaxHandler(e) {
    e.preventDefault();

    const postUrl = $(this).attr('action');
    const formData = $(this).serialize();

    $.post(postUrl, formData, function(response) {
        $.bootstrapGrowl(response.message, {
            offset: { from: 'top', amount: 60 },
            type: 'success'
        });

        $('.cart-count').text(response.cart_count);
    });
}

const ajaxCart = {
    init: function() {
        $(function() {
            $('.cart-form').on('submit', ajaxHandler);
        });
    }
};

export default ajaxCart;
