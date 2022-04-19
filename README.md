## XML_Erudit_To_NLM_DTD
This repository presents an XSLT code designed to convert XML files from Erudit format to NLM DTD.

# What you need first
- The path of your folder containing xml files in Erudit format
- The path of your folder that will contain the translated file
- The path to the XSLT file (erudit_to_nlm.xsl)
- The path to the saxon file (available here: http://saxon.sourceforge.net/)

# How to run the Python code
Make sure you specify these paths in the Python code, and run it. That's it, you will have NLM versions of your Erudit-encoded XML files.

Important note: the converter has been originally designed to convert articles. Main tags such as body, abstract, title, author, section titles, paragraphs, tables and figures are converted properly, but depending on the used tags and Erudit version, some data and metadata can be lost.
