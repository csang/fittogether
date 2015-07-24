if(typeof(CKEDITOR) != 'undefined')
{
 CKEDITOR.editorConfig = function(config) {
	
   config.uiColor = "#2f8352";
   config.toolbar = [
    [ 'Bold', 'Italic', 'Underline', 'Strike' ]
 
   
 ];
}
} else{
  console.log("ckeditor not loaded")
}
