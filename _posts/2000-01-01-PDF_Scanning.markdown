If you are going to scan PDF's to text in linux you need imagemagick
first, you will also need tesseract and the tesseract english training
files.

First convert the pdf into a bunch of high quality tiff files:

    pdfimages -f FIRSTPAGE -l LASTPAGE -j input.pdf out

Then convert them to tiffs, inverting if necissary:

    for EACH in `ls`
    do
    convert -negate $EACH $EACH.tif
    done

Then OCR them:

    for i in $(seq –format=%005.f 1 324)
    do
    tesseract $i.tif tesseract-$i -l eng
    done

Then you can cat them all together:

    cat *.txt > full-output.txt

<Category:PDF> <Category:OCR>
