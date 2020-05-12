# -*- coding : utf-8 -*-

import reportlab.pdfbase.ttfonts as pdfttfonts
from reportlab.lib.pagesizes import A4
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfgen import canvas

pdfmetrics.registerFont(pdfttfonts.TTFont('ms song', 'ms song.ttf'))


ptr = open("C:\\PUMA_AUTO\\RF_PUMA\\PUMA\\Libs\\PUMA_ReportLibrary\\ReportSample\\Report.txt",
           "r", encoding="UTF-8")
content = ptr.read()
ptr.close()
linecount = 0

canvas_obj = canvas.Canvas("hello.pdf")
canvas_obj.setFont("ms song", 10)
canvas_obj.setPageSize(A4)

for text in content.split("\n"):
    print(text)
    canvas_obj.drawString(15, 800 - linecount*1.5, text)
    linecount += 10
canvas_obj.showPage()
canvas_obj.save()
