<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FlatLocChoice.aspx.cs" Inherits="MultiPointChoice" EnableEventValidation="false" %>

<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo"
    TagPrefix="cust" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

            function SingleSlabSelect()
            {
                if(document.getElementById("ctl00_MyCPH1_radMultiple"))
                {
                    document.getElementById("ctl00_MyCPH1_radMultiple").checked = false;
                }
            }

            function MultiSlabSelect()
            {
                if(document.getElementById("ctl00_MyCPH1_radSingle"))
                {
                    document.getElementById("ctl00_MyCPH1_radSingle").checked = false;
                }
            }
            
            function ValidateData()
            {
                //Check for Any one of radio buttons
                if(document.getElementById("ctl00_MyCPH1_radSingle") && document.getElementById("ctl00_MyCPH1_radMultiple"))
                {
                    if(document.getElementById("ctl00_MyCPH1_radSingle").checked == false && document.getElementById("ctl00_MyCPH1_radMultiple").checked == false)
                    {
                        alert("Please select either 'Single Slab Contract' or 'Multi Slab Detailed Contract' to proceed");
                        document.getElementById("ctl00_MyCPH1_radSingle").focus();
                        return false;
                    }
                }
                
                return true;
            }
            
    </script>

    <font class="blackfnt"><b>Edit</b>
        <asp:Label ID="lblstepname" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>
        <b>Choice</b></font><br />
    <br />
    <cust:CustInfo runat="server" ID="cstheader" />
    <div style="width: 10in;" align="center">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <br />
                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <br />
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="width: 39%" valign="top">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td valign="top">
                                                        <table border="0" cellpadding="2" width="85%" cellspacing="1" align="center" class="boxbg">
                                                            <tr style="background-color: White">
                                                                <td colspan="4" align="left" style="height: 200" valign="top">
                                                                    <br>
                                                                    <p align="center">
                                                                        <label class="blackfnt">
                                                                            <b>Choose type of contract </b>
                                                                        </label>
                                                                    </p>
                                                                    <table border="0" cellpadding="2" style="width: 50%;" cellspacing="1" align="center"
                                                                        class="boxbg">
                                                                        <tr style="background-color: White">
                                                                            <td align="left">
                                                                                <input type="radio" id="radSingle" value="S" runat="server" onclick="SingleSlabSelect()" />
                                                                            </td>
                                                                            <td align="left">
                                                                                <label class="blackfnt">
                                                                                    Flat
                                                                                    <asp:Label ID="lblstepfname" runat="server" CssClass="blackfnt"></asp:Label>
                                                                                    Contract
                                                                                </label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr style="background-color: White">
                                                                            <td align="left">
                                                                                <input type="radio" id="radMultiple" value="M" runat="server" onclick="MultiSlabSelect()" />
                                                                            </td>
                                                                            <td align="left">
                                                                                <label class="blackfnt">
                                                                                    Location Wise
                                                                                    <asp:Label ID="lblsteplname" runat="server" CssClass="blackfnt"></asp:Label>
                                                                                    Contract
                                                                                </label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <br />
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr class="bgbluegrey">
                                                                <td>
                                                                    <asp:Button ID="btnSubmit" Text="Submit" runat="server" ToolTip="Click here to submit and proceed"
                                                                        CssClass="blackfnt" OnClientClick="return ValidateData()" OnClick="btnSubmit_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdateProgress ID="uppMain" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right">
                            <img src="../../images/loading.gif" alt="" />
                        </td>
                        <td>
                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                    background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                    opacity: .50; -moz-opacity: .50;" runat="server">
                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                        left: 50%;" ID="Panel2" runat="server">
                    </asp:Panel>
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
</asp:Content>
