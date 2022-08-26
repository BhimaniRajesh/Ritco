<%@ Page EnableEventValidation="false" Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FuelRateMasterEntry.aspx.cs" Inherits="FuelRateMasterEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script src="FuelRateMaster.js" type="text/javascript" type="text/javascript"></script>
     
     
    <script language="javascript" type="text/javascript">


        function check() {

            var Cat = document.getElementById("ctl00_MyCPH1_Txt_Vendor").value;

            var grid = document.getElementById("ctl00_MyCPH1_dgWorkgroup");

            if (Cat == "") {
                alert("Please select Work Group !!!")

                return false;

            }

            var r = grid.rows.length;

            for (k = 0; k < r - 1; k++) {
                j = k + 2
                var pref = "";
                if (j < 10) {
                    pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
                }
                else {
                    pref = "ctl00_MyCPH1_dgWorkgroup_ctl" + j + "_";
                }

                var txtFromCity = document.getElementById(pref + "txtFromCity").value;
                var ddlFuelType = document.getElementById(pref + "ddlFuelType").value;
                var txtRate = document.getElementById(pref + "txtRate").value;

                if (txtFromCity == "") {
                    alert("Please enter From City!")

                    return false;
                }
                
                if (ddlFuelType == "" || ddlFuelType == "00") {
                    alert("Please select Fuel Type!")
                    return false;
                }
                if (txtRate == "") {
                    alert("Please enter Rate!")

                    return false;
                }
            }




            if (r > 0) 
            {
                for (i = 0; i < r - 1; i++) 
                {
                    j = i + 2
                    var pref = "";

                    if (j < 10) 
                    {
                        pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";


                    }
                    else 
                    {
                        //alert("Nat1");
                        pref = "ctl00_MyCPH1_dgWorkgroup_ctl" + j + "_";

                    }

                    Nat1 = document.getElementById(pref + "txtFromCity").value;
                    Nat12 = document.getElementById(pref + "ddlFuelType").value;

//                    alert("1st");
//                    alert(Nat1);
//                    alert(Nat12);
//                    alert(pref);
                    //alert(m);

                    for (k = 0; k < r - 1; k++) {
                    if (i != k) {
                        m = k + 2
//                            alert("m");
//                            alert(m);
                            var pref = "";
                            if (m < 10) 
                            {
                                pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + m + "_";
                            }
                            else {
                                //alert("history 10");
                                pref = "ctl00_MyCPH1_dgWorkgroup_ctl" + m + "_";
                            }

                            Nat11 = document.getElementById(pref + "txtFromCity").value;
                            Nat112 = document.getElementById(pref + "ddlFuelType").value;
                            //alert(K);
//                            alert("2nd");
//                            alert(Nat11);
//                            alert(Nat112);
//                            alert(pref);
                            //alert(m);


                            if (Nat1 == Nat11 && Nat12 == Nat112) 
                            {
//                                alert(Nat11);
//                                alert(Nat112);
                                alert("From City  Cannot  be Duplicate!");
                                document.getElementById(pref + "txtFromCity").focus();

                                return false;
                            }
                        }
                    }
                    
                    
                }
                
            }
        }
        function validFloat(event, txtid) {
            var tb = document.getElementById(txtid);
            var txt = tb.value;
            if (event.keyCode == 13)
                return true;

            if (event.keyCode == 46)
                if (txt.indexOf('.') != -1)
                    event.keyCode = 0;

            if ((event.keyCode < 46 || event.keyCode > 57) || event.keyCode == 47)
            { event.keyCode = 0; return false; }
        }


        function validInt(e) {
            var code;
            if (!e) var e = window.event;
            if (e.keyCode)
                code = e.keyCode;
            else if (e.which)
                code = e.which;
            else
                return true;

            if (code == 13 || code == 8 || code == 9)
                return true;

            if (code < 48 || code > 57) {
                code = 0;
                return false;
            }
        }
    </script>
    <table align="left" cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Fuel Rate Master</asp:Label>
                <br />
                <br />
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        <font class="blackfnt" color="red"><b>Please wait...</b></font>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
    </table>
    <br />
    <br />
    <br />
    <br />
    <br />
    <table align="left" cellspacing="1" style="width: 100%" border="0">
        <tr style="background-color: white">
            <td align="left" colspan="2">
                <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <table align="left" cellspacing="1" cellpadding="2" class="boxbg">
                            <tr style="background-color: white" align="center">
                                <td align="right">
                                    <font class="blackfnt">Enter Vendor </font>&nbsp;
                                </td>
                                <td align="left">
                                    &nbsp;<asp:TextBox ID="Txt_Vendor" runat="server" Width="350" BorderStyle="Groove"
                                        CssClass="blackfnt" onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor')" OnTextChanged="Txt_Vendor_OnChange"
                                        AutoPostBack="true"></asp:TextBox>
                                    <div id="Abc" runat="server" class="boxbg" />
                                    <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                        ServiceMethod="GetVendorFuel" ServicePath="../../AtlasAutoComplete.asmx" TargetControlID="Txt_Vendor">
                                    </ajaxToolkit:AutoCompleteExtender>
                                    <font class="redfnt">Plz Type Initial Character OF Vendor Name </font>
                                </td>
                            </tr>
                        </table>
                       
                        <br />
                        <br />
                        <br />
                         
                         <br />
                        <br />
                        <br />
                        <table align="left" cellspacing="1" cellpadding="2" class="boxbg">
                            <tr style="background-color: white">
                                <td colspan="2">
                                    <asp:Label ID="lblError" runat="server" Visible="False" CssClass="redfnt">
                                 
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white" align="center">
                                <td align="left" width="20%">
                                    <font class="blackfnt">Enter no. of rows </font>&nbsp;&nbsp;
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtRow" runat="server" MaxLength="3" Width="30" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                        BorderStyle="Groove" Text="0" AutoPostBack="true" OnTextChanged="txtRow_TextChanged"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegtxtRow" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                        SetFocusOnError="true" ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td colspan="2">
                                    <asp:DataGrid ID="dgWorkgroup" runat="server" PageSize="1000" OnItemDataBound="dgWorkgroup_ItemDataBound"
                                        OnItemCommand="dgWorkgroup_ItemCommand" AutoGenerateColumns="False" CellPadding="2"
                                        BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px"
                                        CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign="Left">
                                        <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                        <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                        <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center"
                                            Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White"
                                            Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                        <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" HorizontalAlign="Left" />
                                        <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False"
                                            Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="Sr.No.">
                                                <ItemTemplate>
                                                    <center>
                                                        <%# Container.ItemIndex+1 %>.
                                                        <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                    </center>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="From City">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hfTaskCd" runat="server" Value="0" />
                                                    <asp:TextBox ID="txtFromCity" runat="server" BorderStyle="Groove" Width="150px"></asp:TextBox>
                                                    <asp:HiddenField ID="hfFromCity" runat="server" Value="0" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Fuel Type">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlFuelType" runat="server" BorderStyle="Groove" Width="150px">
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Rate">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRate"  runat="server" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        BorderStyle="Groove" Width="75px"></asp:TextBox>
                                                </ItemTemplate>
                                               <%-- "javascript:return validInt(event);" 
                                                "javascript:validFloat(event,this.getAttribute('id'))"--%>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Active Flag">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="ckh_Active_Flag" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td colspan="3" align="center">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" Visible="false" OnClick="btnSubmit_Click"
                                        OnClientClick="javascript:return check()" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Txt_Vendor" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
