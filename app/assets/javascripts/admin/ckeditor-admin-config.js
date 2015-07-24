if(typeof(CKEDITOR) != 'undefined')
{
 CKEDITOR.editorConfig = function(config) {
	 alert('sfddddd')
   config.uiColor = "#2f8352";
   
}
} else{
  console.log("ckeditor not loaded")
}
