<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MACD2.ascx.cs" Inherits="GUI_Fleet_Operations_Issue_AutoComplete_MACD2" %>







<script type="text/javascript" language="javascript">
    // Declaration
    function dacItemClick(cval, nval, t_val3, target1, target2, target3, divid) {
        //alert(foo);
        var divXAC = document.getElementById(divid);
        target1.value = cval;
        if (target2) target2.value = nval;
        if (target3) target3.value = t_val3;
        divXAC.innerHTML = '';
        divXAC.style.display = 'none';
        target1.focus();

    }

    function abc() {
        foo = true;
    }




    function GetDACObj(idd, nmtxtid, tg3id, entity, filt1id, filt2id, fltr_str, divxacid, inoid, minlen, c_idid, fs_stid, ms_fsid) {
        var WebXObj = new Object(); WebXObj.WebxComplete = new Object();
        WebXObj.WebxComplete.Target1 = new Object();
        WebXObj.WebxComplete.Target1 = document.getElementById(idd);
        WebXObj.WebxComplete.Target2 = document.getElementById(nmtxtid);
        WebXObj.WebxComplete.Target3 = document.getElementById(tg3id);
        WebXObj.WebxComplete.Type = entity;
        WebXObj.WebxComplete.filt1 = document.getElementById(filt1id);
        WebXObj.WebxComplete.filt2 = document.getElementById(filt2id);
        WebXObj.WebxComplete.filtstr = document.getElementById(fltr_str);
        WebXObj.WebxComplete.div = document.getElementById(divxacid);
        WebXObj.WebxComplete.ino = document.getElementById(inoid);
        WebXObj.WebxComplete.preflen = minlen;
        WebXObj.WebxComplete.currid = document.getElementById(c_idid);
        WebXObj.WebxComplete.fs_st = document.getElementById(fs_stid);
        WebXObj.WebxComplete.ms_fs = document.getElementById(ms_fsid);

        if (WebXObj.WebxComplete.Target1)
            WebXObj.WebxComplete.Target1.autocomplete = 'off';

        if (WebXObj.WebxComplete.Target2)
            WebXObj.WebxComplete.Target2.autocomplete = 'off';

        return WebXObj;
    }

    // JScript File
    function dacKeyDown(e, WEBX) {
        WEBX.WebxComplete.div.style.position = 'absolute';
        var code; if (!e) var e = window.event; if (e.keyCode) code = e.keyCode; else if (e.which) code = e.which; else return true;

        if (code == 40) {
            var i = parseInt(document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value);
            var cval_pre = document.getElementById('tcd' + i);
            i++;
            var cval_nex = document.getElementById('tcd' + i);

            if (cval_pre && cval_nex) {
                cval_nex.style.color = 'black';
                cval_nex.setAttribute("font-weight", "normal");
                cval_pre.style.fontWeight = 'normal';
                cval_pre.setAttribute("bgColor", "#FFFFFF");
                cval_pre.style.color = 'black';
            }
            if (cval_nex) {
                document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value = i;
                cval_nex.setAttribute("font-weight", "bold");
                cval_nex.style.fontWeight = 'bold';
                cval_nex.setAttribute("bgColor", "yellow");
            }
        }
        else if (code == 38) {
            var i = parseInt(document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value);
            var cval_pre = document.getElementById('tcd' + i);
            i--;
            var cval_nex = document.getElementById('tcd' + i);
            if (cval_pre && cval_nex) {
                cval_nex.style.color = 'black'; document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value = i;
                cval_nex.setAttribute("font-weight", "normal");
                cval_pre.style.fontWeight = 'normal';
                cval_pre.setAttribute("bgColor", "#FFFFFF");
                cval_pre.style.color = 'black';
            }
            if (cval_nex) {
                cval_nex.setAttribute("font-weight", "bold");
                cval_nex.style.fontWeight = 'bold';
                cval_nex.setAttribute("bgColor", "yellow");
            }
        }
        else if (code == 27) {
            WEBX.WebxComplete.div.innerHTML = '';
            WEBX.WebxComplete.div.style.display = 'none';
        }
        else if (code == 9 || code == 13) {
            var i = parseInt(document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value);
            var cval = document.getElementById("cval" + document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value);
            var nval = document.getElementById("nval" + document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value);
            var t_val3 = document.getElementById("t_val3" + document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value);
            if (cval) WEBX.WebxComplete.Target1.value = cval.innerText;
            if (nval && WEBX.WebxComplete.Target2) WEBX.WebxComplete.Target2.value = nval.innerText;
            if (t_val3 && WEBX.WebxComplete.Target3) WEBX.WebxComplete.Target3.value = t_val3.innerText;

            WEBX.WebxComplete.div.innerHTML = '';
            WEBX.WebxComplete.div.style.display = 'none';
            WEBX.WebxComplete.Target1.focus();
            event.returnValue = false;
            event.cancel = true;
        }
        else {
            event.returnValue = false;
            event.cancel = true;
        }
        return false;
    }


    function dacCodeKeyUp(e, WEBX, init) {
        WEBX.WebxComplete.div.style.position = 'absolute'; WEBX.WebxComplete.div.width = '300px';
        WEBX.WebxComplete.Target1.autocomplete = 'off';
        var code; if (!e) var e = window.event; if (e.keyCode) code = e.keyCode; else if (e.which) code = e.which; else return true;
        if (code == 8 || code == 46) {
            if (parseInt(WEBX.WebxComplete.Target1.value.length) < WEBX.WebxComplete.preflen + 2) {
                WEBX.WebxComplete.div.innerHTML = '';
                WEBX.WebxComplete.div.style.display = 'none';
                return false;
            }
        }
        else {
            if (parseInt(WEBX.WebxComplete.Target1.value.length) < WEBX.WebxComplete.preflen) {
                WEBX.WebxComplete.div.innerHTML = ''; WEBX.WebxComplete.div.style.display = 'none';
                return false;
            }
        }

        if (code == 40) {
            if (WEBX.WebxComplete.div.style.display == 'none') return false;
            WEBX.WebxComplete.div.focus();
            WEBX.WebxComplete.fs_st.value = "1";
            document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value = "1";
            var cval_nex = document.getElementById('tcd1');
            if (cval_nex) {
                cval_nex.setAttribute("font-weight", "bold");
                cval_nex.style.fontWeight = 'bold';
                cval_nex.setAttribute("bgColor", "yellow");
            }

        }
        else if (code == 38 || code == 37 || code == 39 || code == 13) { event.returnValue = false; event.cancel = true; }
        else if (code == 9) {
            WEBX.WebxComplete.div.style.display = 'none';
            WEBX.WebxComplete.div.innerHTML = '';
        }
        else {
            var findobj = false;
            findobj = GetXMLHttpObject();
            if (findobj) {
                var fileURL = new String(document.location)
                var cnt = fileURL.indexOf("/GUI/", 0);

                var strpg = fileURL.substring(0, cnt) + '/GUI/Fleet/Operations/Issue/AutoComplete/_mac_dataD2.aspx?tp=' + WEBX.WebxComplete.Type + '&target1=' + WEBX.WebxComplete.Target1.getAttribute('id');
                if (WEBX.WebxComplete.Target2)
                    strpg = strpg + '&target2=' + WEBX.WebxComplete.Target2.getAttribute('id');
                else
                    strpg = strpg + '&target2=';
                if (WEBX.WebxComplete.Target3)
                    strpg = strpg + '&target3=' + WEBX.WebxComplete.Target3.getAttribute('id');
                else
                    strpg = strpg + '&target3=';

                strpg = strpg + '&code1=' + WEBX.WebxComplete.Target1.value;
                if (WEBX.WebxComplete.filt1)
                    strpg = strpg + "&filt1=" + WEBX.WebxComplete.filt1.value;
                else
                    strpg = strpg + "&filt1=";
                if (WEBX.WebxComplete.filt2)
                    strpg = strpg + "&filt2=" + WEBX.WebxComplete.filt2.value;
                else
                    strpg = strpg + "&filt2=";
                strpg = strpg + "&filtstr=" + WEBX.WebxComplete.filtstr.value;
                strpg = strpg + "&divid=" + WEBX.WebxComplete.div.getAttribute('id');
                strpg = strpg + '&sid=' + Math.random() + '&sid=' + Math.random();
                findobj.open('GET', strpg);

                findobj.onreadystatechange = function () {
                    if ((findobj.readyState == 4) && (findobj.status == 200)) {

                        WEBX.WebxComplete.div.innerHTML = '';
                        if (init.value == "0")
                            return;
                        var resp = findobj.responseText.split("</html>");
                        WEBX.WebxComplete.div.innerHTML = resp[1];
                        WEBX.WebxComplete.div.style.display = 'block';
                        var ht = "";
                        ht = document.getElementById("tblmain").offsetHeight;
                        if (ht == "") ht = "0";

                        if (parseInt(ht) > 10) WEBX.WebxComplete.div.style.display = 'block'; else WEBX.WebxComplete.div.style.display = 'none';

                        if (parseInt(ht) < 300)
                            WEBX.WebxComplete.div.style.height = document.getElementById("tblmain").style.height;
                        else
                            WEBX.WebxComplete.div.style.height = "200px";
                    }
                }
                findobj.send(null);
            }
        }

    }

    function dacCodeBlur(fs_st, div, ino, target, init) {
        if (fs_st.value == "0") {
            var ino = document.getElementById(fs_st.getAttribute('id').substring(0, parseInt(fs_st.getAttribute('id').length) - 5) + 'ino');
            var code = document.getElementById('tcd' + ino.value);
            div.innerHTML = ''; div.style.display = 'none';
            init.value = "0";
        }
        ino.value = "1"; target.value = target.value.toUpperCase();
    }

    function dacCodeFocus(fs_st, div, ino, target, init) {
        init.value = "1";
    }

    function dacMouseOver(fs_st, ms_fs) {
        fs_st.value = "1"; ms_fs.value = '1';
    }

    function dacMouseOut(fs_st, ms_fs) {
        fs_st.value = "0"; ms_fs.value = '0';
    }

    function dacFocus(code)
    { }

    function dacBlur(e, div, ms_fs, ino) {
        if (ms_fs.value == '0') {
            div.style.display = 'none';
        }
    }

    function dacItemMouseOver(tr, cval) {
        tr.setAttribute("font-weight", "bold");
        tr.style.fontWeight = 'bold';
        tr.setAttribute("bgColor", "yellow");
        tr.style.cursor = 'pointer';
    }

    function dacItemMouseOut(tr, cval) {
        tr.setAttribute("font-weight", "normal");
        tr.style.fontWeight = 'normal';
        tr.setAttribute("bgColor", "white");
    }
</script>

<asp:Panel ID="divXAC" Style="position: absolute; width: 300px; display: none; z-index: 10000;
    cursor: pointer; scrollbar-base-color: #d4e0e7; scrollbar-3dlight-color: #d4e0e7;
    scrollbar-highlight-color: #d4e0e7; scrollbar-shadow-color: #d4e0e7;" ScrollBars="Both"
    Width="2in" runat="server">
</asp:Panel>
<asp:HiddenField ID="ino" Value="0" runat="server" />
<asp:HiddenField ID="c_id" Value="0" runat="server" />
<asp:HiddenField ID="fs_st" Value="0" runat="server" />
<asp:HiddenField ID="fltr_str" runat="server" />
<asp:HiddenField ID="init" Value="0" runat="server" />
<asp:HiddenField ID="ms_fs" Value="0" runat="server" />

