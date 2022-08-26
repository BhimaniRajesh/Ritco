 $(document).ready(function () {
            $("#spinner").bind("ajaxSend", function () {
                $(this).show();
            }).bind("ajaxStop", function () {
                $(this).hide();
            }).bind("ajaxError", function () {
                $(this).hide();
            });
            $(function () {
               // showDatePicker();
            });
        });

        function printPDF(btn) {
            //ServerCallBeforePrint(btn);
            printReport(btn);
        }

        function showPrintButton(btn) {
            var table = $("table[title='Refresh']");
            var parentTable = $(table).parents('table');
            var parentDiv = $(parentTable).parents('div').parents('div').first();
            var btnPrint = $("<input type='button' id='btnPrint' name='btnPrint' value='Print' style=\"font-family:Verdana;font-size:8pt;width:86px\"/>");
            var btnClose = $("<input type='button' id='btnClose' name='btnClose'value='Close' style=\"font-family:Verdana;font-size:8pt;width:86px\"/>");
            btnPrint.click(function () {
                printPDF(btn);

            });
            btnClose.click(function () {
                window.close();
            });
            if (parentDiv.find("input[value='Print']").length == 0) {
                parentDiv.append('<table cellpadding="0" cellspacing="0" toolbarspacer="true" style="display:inline-block;width:6px;"><tbody><tr><td></td></tr></tbody></table>');
                parentDiv.append('<div id="customDiv" class=" " style="display:inline-block;font-family:Verdana;font-size:8pt;vertical-align:inherit;"><table cellpadding="0" cellspacing="0"><tbody><tr><td><span style="cursor:pointer;" class="HighlightDiv" onclick="javascript:printPDF(this);" ><img src="../../../images/png/24/printer.png" alt="Print Report" title="Print Report" width="25px" height="25px" style="margin-top:4px"/></span></td></tr></tbody></table></div>');
                parentDiv.append('<table cellpadding="0" cellspacing="0" toolbarspacer="true" style="display:inline-block;width:10px;"><tbody><tr><td></td></tr></tbody></table>');
                parentDiv.append('<div id="customDiv" class=" " style="display:inline-block;font-family:Verdana;font-size:8pt;vertical-align:inherit;"></div>');
            }
        }
        //Generate Print in Chrome for  
        function printReport(report_ID) {
            var rv1 = $('#ReportViewer1');
            var iDoc = rv1.parents('html');

            // Reading the report styles
            var styles = iDoc.find("head style[id$='ReportControl_styles']").html();
            if ((styles == undefined) || (styles == '')) {
                iDoc.find('head script').each(function () {
                    var cnt = $(this).html();
                    var p1 = cnt.indexOf('ReportStyles":"');
                    if (p1 > 0) {
                        p1 += 15;
                        var p2 = cnt.indexOf('"', p1);
                        styles = cnt.substr(p1, p2 - p1);
                    }
                });
            }
            if (styles == '') { alert("Cannot generate styles, Displaying without styles.."); }
            styles = '<style type="text/css">' + styles + "</style>";

            // Reading the report html
            var table = rv1.find("div[id$='_oReportDiv']");
            if (table == undefined) {
                alert("Report source not found.");
                return;
            }

            // Generating a copy of the report in a new window
            var docType = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/loose.dtd">';
            var docCnt = styles + table.parent().html();
            var docHead = '<head><title>Printing ...</title><style>body{margin:5;padding:0;}</style></head>';
            var winAttr = "location=yes,statusbar=no,directories=no,menubar=no,titlebar=no,toolbar=no,dependent=no,width=720,height=600,resizable=yes,screenX=200,screenY=200,personalbar=no,scrollbars=yes";;
            var newWin = window.open("", "_blank", winAttr);
            writeDoc = newWin.document;
            writeDoc.open();
            writeDoc.write(docType + '<html>' + docHead + '<body onload="window.print();">' + docCnt + '</body></html>');
            writeDoc.close();

            // The print event will fire as soon as the window loads
            newWin.focus();
            // uncomment to autoclose the preview window when printing is confirmed or canceled.
            // newWin.close();
        };