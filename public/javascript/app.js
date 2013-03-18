

$(function() {

    $("#yoko").keyup(function(e){
        var text = $('#yoko').val();
        $("#yoko_length").text(text.length);

        vText= H2V.h2vText(text);
        vText = H2V.transStrH2V(vText);
        $('#tate').val(vText);
        $("#tate_length").text(vText.length);
    });

    $("#tate").keyup(function(e){
        var text = $('#tate').val();
        $("#tate_length").text(text.length);

        hText= H2V.v2hText(text);
        hText = H2V.transStrV2H(hText);
        $('#yoko').val(hText);
        $("#yoko_length").text(hText.length);
    });

    $("#tweet_tate").click(function(e) {
        var text = $('#tate').val();
        var url = H2V.get_tweetURL(text);
        window.open(url);
    });
});

