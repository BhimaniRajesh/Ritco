<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FTLSundryChoice.aspx.cs" Inherits="MultiPointChoice" EnableEventValidation="false" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

  


    <script language="javascript" type="text/javascript">

            function SingleSlabSelect()
            {
                if(document.getElementById("ctl00_MyCPH1_optftl"))
                {
                    document.getElementById("ctl00_MyCPH1_optftl").checked = false;
                }
            }

            function MultiSlabSelect()
            {
                if(document.getElementById("ctl00_MyCPH1_optsundry"))
                {
                    document.getElementById("ctl00_MyCPH1_optsundry").checked = false;
                }
            }
            
            function ValidateData()
            {
                //Check for Any one of radio buttons
                if(document.getElementById("ctl00_MyCPH1_optsundry") && document.getElementById("ctl00_MyCPH1_optftl"))
                {
                    if(document.getElementById("ctl00_MyCPH1_optsundry").checked == false && document.getElementById("ctl00_MyCPH1_optftl").checked == false)
                    {
                        alert("Please select either 'Single Slab Contract' or 'Multi Slab Detailed Contract' to proceed");
                        document.getElementById("ctl00_MyCPH1_optsundry").focus();
                        return false;
                    }
                }
                
                return true;
            }
            
    </script>

    <font class="blackfnt">Customer Contract Master >> </font><font class="blackfnt">Edit
        MultiPoint Choice</font><br />
    <font class="blackfnt">Customer >> </font>
    <asp:Label ID="lblcustcodename" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
    <hr align="center" size="1" style="color: #8ba0e5" />
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
                                                                        <tr style="background-color: White;  display:none;" id="trsundry" runat="server">
                                                                            <td align="left">
                                                                                <asp:RadioButton ID="optsundry" runat="server" GroupName="service" />
                                                                            </td>
                                                                            <td align="left">
                                                                                <label class="blackfnt">
                                                                                    Sundry
                                                                                </label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr style="background-color: White; display:none;" id="trftl" runat="server">
                                                                            <td align="left">
                                                                                <asp:RadioButton ID="optftl" runat="server" GroupName="service" />
                                                                            </td>
                                                                            <td align="left">
                                                                                <label class="blackfnt">
                                                                                    FTL
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
        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
            <ProgressTemplate>
                <div id="progressArea">
                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
</asp:Content>
