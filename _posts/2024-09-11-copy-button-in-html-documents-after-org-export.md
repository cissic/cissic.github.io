
# Table of Contents

1.  [Copy button in html documents after org export](#org726d36b)
    1.  [Dependencies](#org423579a)
    2.  [Solution](#org1d9d826)
        1.  [Define javascript source block](#org99b958e)
        2.  [Insert the javascript code in html document](#org376c77c)
        3.  [Define an elisp function supporting custom html export.](#org84c6744)
    3.  [The example of usage](#org58809f6)
2.  [Issues:](#orgd079278)



<a id="org726d36b"></a>

# Copy button in html documents after org export

Basing on these threads: 
[1](https://www.reddit.com/r/emacs/comments/blbfeu/orgmode_copy_source_block_button/),
[2](https://emacs.stackexchange.com/questions/31260/what-would-be-the-simplest-way-to-add-a-copy-to-clipboard-button-to-html-expor/31498#31498),
[3](https://stackoverflow.com/questions/400212/how-do-i-copy-to-the-clipboard-in-javascript/30810322#30810322),
[4](https://emacs.stackexchange.com/questions/28301/export-javascript-source-block-to-script-tag-in-html-when-exporting-org-file-to)
I tried to implement a nice feature which is a 'copy button'
for org-babel source blocks in the final html version of an org-mode 
document.

The solution is described primarily in [2](https://emacs.stackexchange.com/questions/31260/what-would-be-the-simplest-way-to-add-a-copy-to-clipboard-button-to-html-expor/31498#31498) however it didn't work
for me at first because of quotation marks
in a code reused from link [3](https://stackoverflow.com/questions/400212/how-do-i-copy-to-the-clipboard-in-javascript/30810322#30810322).
That is why I decided to rewrite the whole solution here.

The solution is contained to one file. In case of mutliple
html document it requires optimization in order to reuse javascript code.


<a id="org423579a"></a>

## Dependencies

You need to have the following packages in your emacs:

-   `ox`,
-   `s`,
-   `uuidgen`.


<a id="org1d9d826"></a>

## Solution


<a id="org99b958e"></a>

### Define javascript source block

**Important remark**: replace line

`var textArea = document.createElement("textarea");`

from the source [3](https://stackoverflow.com/questions/400212/how-do-i-copy-to-the-clipboard-in-javascript/30810322#30810322) with

`var textArea = document.createElement('textarea');`

otherwise you are sure to obtain an error during the export of the
document. 

    function copyTextToClipboard(text) {
      var textArea = document.createElement('textarea');
    
      //
      // *** This styling is an extra step which is likely not required. ***
      //
      // Why is it here? To ensure:
      // 1. the element is able to have focus and selection.
      // 2. if the element was to flash render it has minimal visual impact.
      // 3. less flakyness with selection and copying which **might** occur if
      //    the textarea element is not visible.
      //
      // The likelihood is the element won't even render, not even a
      // flash, so some of these are just precautions. However in
      // Internet Explorer the element is visible whilst the popup
      // box asking the user for permission for the web page to
      // copy to the clipboard.
      //
    
      // Place in the top-left corner of screen regardless of scroll position.
      textArea.style.position = 'fixed';
      textArea.style.top = 0;
      textArea.style.left = 0;
    
      // Ensure it has a small width and height. Setting to 1px / 1em
      // doesn't work as this gives a negative w/h on some browsers.
      textArea.style.width = '2em';
      textArea.style.height = '2em';
    
      // We don't need padding, reducing the size if it does flash render.
      textArea.style.padding = 0;
    
      // Clean up any borders.
      textArea.style.border = 'none';
      textArea.style.outline = 'none';
      textArea.style.boxShadow = 'none';
    
      // Avoid flash of the white box if rendered for any reason.
      textArea.style.background = 'transparent';
    
    
      textArea.value = text;
    
      document.body.appendChild(textArea);
      textArea.focus();
      textArea.select();
    
      try {
        var successful = document.execCommand('copy');
        var msg = successful ? 'successful' : 'unsuccessful';
        console.log('Copying text command was ' + msg);
      } catch (err) {
        console.log('Oops, unable to copy');
      }
    
      document.body.removeChild(textArea);
    }


<a id="org376c77c"></a>

### Insert the javascript code in html document

The above script will be exported to the html document
by
adding the following code to your org-document.

    #+begin_src elisp :noweb yes :exports results :results html 
    (concat
    "<script type=\"text/javascript\">\n"
    "
    <<inline-js>>
    "
    "\n"
    "</script>")
    #+end_src

<script type="text/javascript">

function copyTextToClipboard(text) {
  var textArea = document.createElement('textarea');

  //
  // *** This styling is an extra step which is likely not required. ***
  //
  // Why is it here? To ensure:
  // 1. the element is able to have focus and selection.
  // 2. if the element was to flash render it has minimal visual impact.
  // 3. less flakyness with selection and copying which **might** occur if
  //    the textarea element is not visible.
  //
  // The likelihood is the element won't even render, not even a
  // flash, so some of these are just precautions. However in
  // Internet Explorer the element is visible whilst the popup
  // box asking the user for permission for the web page to
  // copy to the clipboard.
  //

  // Place in the top-left corner of screen regardless of scroll position.
  textArea.style.position = 'fixed';
  textArea.style.top = 0;
  textArea.style.left = 0;

  // Ensure it has a small width and height. Setting to 1px / 1em
  // doesn't work as this gives a negative w/h on some browsers.
  textArea.style.width = '2em';
  textArea.style.height = '2em';

  // We don't need padding, reducing the size if it does flash render.
  textArea.style.padding = 0;

  // Clean up any borders.
  textArea.style.border = 'none';
  textArea.style.outline = 'none';
  textArea.style.boxShadow = 'none';

  // Avoid flash of the white box if rendered for any reason.
  textArea.style.background = 'transparent';


  textArea.value = text;

  document.body.appendChild(textArea);
  textArea.focus();
  textArea.select();

  try {
    var successful = document.execCommand('copy');
    var msg = successful ? 'successful' : 'unsuccessful';
    console.log('Copying text command was ' + msg);
  } catch (err) {
    console.log('Oops, unable to copy');
  }

  document.body.removeChild(textArea);
}

</script>


<a id="org84c6744"></a>

### Define an elisp function supporting custom html export.

With the use of `copyTextToClipboard` function defined above
we can implement our own way of exporting org-document to html.

     (require 'ox)
     (require 's)
     (require 'uuidgen)
     (defun mvr-html-src-block (src-block contents info)
       "Transcode a SRC-BLOCK element from Org to HTML, adding a 'copy to clipboard' button."
       (if (not (org-export-read-attribute :attr_html src-block :copy-button))
        (org-export-with-backend 'html src-block contents info)
        (let*((b-id (concat "btn_" (s-replace "-" "" (uuidgen-4))))
          (content (let ((print-escape-newlines t))(prin1-to-string (org-export-format-code-default src-block info))))
          (content- (s-chop-prefix "\"" (s-chop-suffix "\"" (s-replace "`" "\\`" content))))
          (btn- "button")
          (scr- "script")
          (bquote- "`")
          (script (concat "\n<" scr- " type='text/javascript'>\n var copyBtn" b-id "=document.querySelector('" btn- "[name=" b-id "]');\n"
                          "copyBtn" b-id ".addEventListener('click', function(event) {\n"
                          "copyTextToClipboard(" bquote- content- bquote- ");\n});\n</" scr- ">\n"))
          (button (concat "<" btn- " class='copyBtn' name=" b-id ">Copy to clipboard</" btn- ">")))
          (concat (org-export-with-backend 'html src-block contents info)  button script))))
    
     (org-export-define-derived-backend 'mvr-html 'html
       :translate-alist '((src-block . mvr-html-src-block)))
    
    (defun org-export-to-html-with-button (file)
    "Exports the current org-mode buffer to an HTML file, adding 'copy to clipboard' 
    buttons to source code blocks."
    (interactive "FFile Name: ")
    (org-export-to-file 'mvr-html file))


<a id="org58809f6"></a>

## The example of usage

The copy button is then enabled by adding
`#+ATTR_HTML: :copy-button t`
to the relevant source blocks, like so

    #+ATTR_HTML: :copy-button t :width 40
    #+begin_src python
       import numpy as np
       import matplotlib as mtl
    #+end_src

Now after `M-x org-export-to-html-with-button`
you need to give a name of the html document to export
document with copy-button feature.

If this org document is processed with
`M-x org-export-to-html-with-button`
you'll obtain copy-button below the following block:

    import numpy as np
    import matplotlib as mtl


<a id="orgd079278"></a>

# TODO Issues:

-   [ ] automatic solution requires reloading default html exporter
-   [ ] markdown exporter needs seperate treatment
-   [ ] Need to find magic/versatile solution

