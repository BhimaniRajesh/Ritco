<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProgressBarJs.ascx.cs" Inherits="GUI_Common_UserControls_ProgressBarJs" %>

<script src="<%= ResolveUrl("~/GUI/Js/ProgressBar.js") %>" type="text/javascript"></script>

<div id="Progress_Bar" style="display: none">
    <div style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"></div>
    <div style="left: 43%; padding: 10px; position: fixed; top: 30%; width: 14%; z-index: 1001;">
        <table cellspacing="2" class="boxbg" style="z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;"
            width="190px" cellpadding="0">
            <tr class="bgwhite">
                <td>
                    <table>
                        <tr class="bgwhite">
                            <td align="right">
                                <img id="imgloading" src="<%=ResolveClientUrl("~/GUI/images/loading.gif") %>" />
                            </td>
                            <td class="blackfnt">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</div>
