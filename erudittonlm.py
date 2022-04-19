"""
Author: Jamil ZAGHIR
Date: 12.22.2021
"""

import os
import sys
# Add sys path if necessary
# sys.path.append(os.path.abspath('../'))
from xml.sax.handler import ContentHandler
from xml.sax import make_parser
import glob
import subprocess


def XML_wellformedness(path_to_nlm_file):
    parser = make_parser()
    parser.setContentHandler(ContentHandler())
    parser.parse(path_to_nlm_file)


def file_path(relative_path):
    folder = os.path.dirname(os.path.abspath(__file__))
    path_parts = relative_path.split("/")
    new_path = os.path.join(folder, *path_parts)
    return new_path


def transform(xml_file, xsl_file, output_file):
    """all args take relative paths from Python script"""
    input_ = file_path(xml_file)
    output_ = file_path(output_file)
    xslt = file_path(xsl_file)
    subprocess.call("java -cp " + saxon_path + f" net.sf.saxon.Transform -t -s:{input_} -xsl:{xslt} -o:{output_}")


if __name__ == '__main__':
    # PATHS
    folder_in = 'C:\\Users\\XXXX\\FolderContainingEruditFormatXMLFiles'
    folder_out = 'C:\\Users\\XXXX\\PathToTheFolderToSaveTheTranslatedFiles'
    xslt_path = 'C:\\Users\\XXXX\\erudit_to_nlm.xsl'
    saxon_path = "C:\\saxon\saxon-he-10.5.jar"

    # Iterate over xml articles
    article_count = 0
    articles = len(glob.glob(folder_in + "/**/*.xml", recursive=True))
    print("There are {} xml files to transform".format(articles))

    for f in glob.iglob(os.path.join(folder_in, "**"), recursive=True):   
        if os.path.isfile(f): 
            (chemin, filename) = os.path.split(f)
            (filename_wo_ext, ext) = os.path.splitext(filename)
            if ext in ['.xml', '.XML']:
                print("{}/ {}".format(str(article_count), articles))
                if not os.path.exists(folder_out):
                    os.makedirs(folder_out)
                    print("Creating "+ folder_out)
                article_count +=1
                output_path = os.path.join(folder_out, filename)
                
                # Call transform function
                dom = transform(f, xslt_path, output_path)
                # Validate it
                try:
                    XML_wellformedness(output_path)
                    print("%s is well-formed" % output_path)
                except Exception as e:
                    print("%s is NOT well-formed! %s" % (output_path, e))
                    break

