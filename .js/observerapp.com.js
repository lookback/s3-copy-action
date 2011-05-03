function swap_colors(){
    $('div').each(function (index) {
        if ($(this).css('background-color') === '#EFF4F6'){
            $(this).css('background-color') = 'red';
        }
    })
}

setTimeout(function (){swap_colors()}, 5000);
