<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_DocketYetNotDelivered_Result" EnableEventValidation="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript">
    
    	function DrillDown(Fromdt,todt,loc,rptmd)
			{	
				var strPopupURL = "Result_Detail.aspx?Fromdt=" + Fromdt +"&todt=" + todt +"&loc=" + loc +"&rptmd="+rptmd;
				winNew = window.open(strPopupURL, "_self")
			}
    
    </script>

    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        <strong>Operation </strong></font><font class="bluefnt"><strong></strong>&gt;<strong>Docket
                            Yet Not Delivered Report</strong> </font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="./../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="./../../images/back.gif" border="0">
                </a>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p align="left">
                    <label class="blackfnt">
                        <b>You Selected </b>
                    </label>
                </p>
                <table runat="server" id="TBL_CRI" border="0" cellpadding="3" width="400" cellspacing="1"
                    align="left" class="boxbg">
                    <tr style="background-color: #ffffff">
                        <td style="height: 10px">
                            <label class="blackfnt">
                                Date :</label></td>
                        <td style="height: 10px">
                            <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 15px;">
                            <label class="blackfnt">
                                RO :</label></td>
                        <td style="width: 343; height: 15px;">
                            &nbsp;
                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205">
                            <label class="blackfnt">
                                Location :</label></td>
                        <td style="width: 343">
                            &nbsp;
                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left">
                <br />
                <asp:Button ID="btn_csv1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv1_Click" />
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <asp:Table id="TBL_CF"  border="0" HorizontalAlign="left" runat="server" CellPadding="3" CellSpacing="1" style="width:9.5in; border:1" CssClass="boxbg"></asp:Table>
            </td>
        </tr>
        <tr>
            <td align="left">
                <br />
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
