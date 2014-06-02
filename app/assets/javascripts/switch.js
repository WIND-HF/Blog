$(":song").change(function(){
    var file = this.files[0];
    var name = file.name;
    var size = file.size;
    var type = file.type;
});
$(":button").click(function() {
    var formData = new FormData($("form")[0]);
    alert("Hello");
    $.ajax({
        url: "/switch/upload",
        type: "POST",
        xhr: function() {  // Custom XMLHttpRequest
            var myXhr = $.ajaxSettings.xhr();
            if(myXhr.upload){ // Check if upload property exists
                myXhr.upload.addEventListener('progress',progressHandlingFunction, false); // For handling the progress of the upload
            }
            return myXhr;
        },
        beforeSend: beforeSendHandler,
        success: completeHandler,
        error: errorHandler,
        data: formData,
        cache: false,
        contentType: false,
        processData: false
        //dataType: "JSON"
    });//.done(function(data) {alert(data)});
});
function lkplay(filename, content, filetype) {
    //alert("Hello World");
    var $song = $("#" + content);
    if (document.getElementById(filename) == null) {
        $song.append("<audio controls><source></source></audio>");
        $song.find("source").attr("src", filename).attr("type", filetype).attr("id", filename);
    }
    else {
        $song.find("audio").remove();
    }
}
function ajaxGetJSON(url, content) {
    var posting = $.getJSON(url, {id: content});
    posting.done(function(data) {
        //var obj = JSON.parse(data);
        //alert(data.name);
        var filetype = '';
        if (data.type == 'wav') {
            filetype = 'audio/wav';
        }
        else if (data.type == 'mp3') {
            filetype = 'audio/mpeg';
        } else {
            filetype = data.type;
        }
        lkplay(data.path, content, filetype);
    });
}
function ajaxUpdate() {
    var $rlt = $("#playlist");
    $rlt.empty();
    $rlt.load("/switch/music #playlist li");
}
