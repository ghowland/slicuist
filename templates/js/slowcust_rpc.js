// RPC: Remote Procedure Call, automated back to path/rpc/FunctionName
//
// On return will automatically fill in Object() key results into tag IDs of
//    the same name.  If "__js" key is found, assumes this is a array of strings
//    and performs an eval() on each after updating all the tag IDs
//
function RPC(url, input_data, on_complete_function) {
  //alert('RPC: ' + rpc + ': ' + input_data.toSource())  // Use to test

  // AJAX Code To Submit Form.
  $.ajax({
    type: "POST",
    url: url,
    data: input_data,
    cache: false,
    success: function(data)
      {
        ProcessRPCData(data);
        if (typeof on_complete_function != 'undefined') { on_complete_function(); }
      }
  });
}


function RPCUrl(url, data) {
  $.getJSON(url, function(data) {
    ProcessRPCData(data);
  });
}


// Process the RPC response data, can be done without using the RPC call as well
function ProcessRPCData(data) {
  var js_data = undefined;
  var reload_page = undefined;
  var load_page = undefined;

  alert(data);
  data = JSON.parse(data);
  alert(data);

  // Process the HTML sections, skip __js and __js_data
  for (var key in data)
  {
    // Non-Javascript data gets put into ID elements, if they exist
    if (key != '__js' && key != '__js_data' && key != '__reload_page' && key != '__load_page') {
      //TODO(g): Is it worth checking if the ID exists in the DOM?  I dont think so, but think about it...
      // Start by clearing the existing data and freeing references
      $("#" + key).empty();
      //alert('Procesing: ' + key + ' :: ' + data[key]);
      $("#" + key).html(data[key]);
    }
    // Save our Javascript array until later so we can deal with it then
    else if (key == '__js') {
      js_data = data[key];
    }
    // Save our Javascript array until later so we can deal with it then
    else if (key == '__js_data') {
      js_data = data[key];
    }
    // Else, if this is a key to reload the page (self or somewhere else)
    else if (key == '__reload_page') {
      reload_page = data[key];
    }
    // Else, if this is a key to load a page
    else if (key == '__load_page') {
      load_page = data[key];
    }
  }
  
  // If we had JS data, eval() it all now.  After we have updated all
  //    the ID data
  if (js_data != undefined) {
    for (var count in js_data) {
      alert(js_data[count]);
      eval(js_data[count]);
    }
  }
  
  // Reload the page
  if (reload_page != undefined) {
    location.reload();
  }
  // Load a page
  else if (load_page != undefined) {
    window.location = load_page;
  }  
}

