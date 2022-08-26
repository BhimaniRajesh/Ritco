<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="TripRuleMaster.aspx.cs" Inherits="GUI_Fleet_TripRuleMaster" Title="Trip Rule Setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script type="text/javascript" language="javascript" src="../images/commonJs.js" ></script>
<script type="text/javascript" language="javascript">
function CheckTripsheetNo(Chk_Settlement_Pending,txtTripsheetNo)
{
    if(Chk_Settlement_Pending!=null)
    {
        if(Chk_Settlement_Pending.checked == true)
        {
            if(txtTripsheetNo.value == "")
            {
                alert("Please Enter No. of Trip Sheet");
                txtTripsheetNo.value="";
                txtTripsheetNo.focus();
                return false;
            }
        }
        else
        {
            txtTripsheetNo.value="";
        }       
    }
}
function SubmitData()
{
    var txtTripsheetNo = document.getElementById("ctl00_MyCPH1_txtTripsheetNo");
    var Chk_Settlement_Pending = document.getElementById("ctl00_MyCPH1_Chk_Settlement_Pending");
    
    if(Chk_Settlement_Pending !=null)
    {
        if(Chk_Settlement_Pending.checked == true)
        {
            if(txtTripsheetNo.value == "")
            {
                alert("Please Enter No. of Trip Sheet");
                txtTripsheetNo.value="";
                txtTripsheetNo.focus();
                return false;
            }
        }
        else
        {
            txtTripsheetNo.value="";
        }       
    }
}
</script>

    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../images/loading.gif" alt="" />
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
    <%-- <asp:Table ID="Table1" runat="server" CellSpacing="1" Width="500px">
        <asp:TableRow Style="background-color: white">
            <asp:TableCell HorizontalAlign="left" Width="50%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server" Text="Trip Rule Master" />
            </asp:TableCell>
            <asp:TableCell Width="50%" HorizontalAlign="Right">
                       
               
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>--%>
    <br />
    <br />
    <br />
    <asp:UpdatePanel runat="server" ID="UpPanel">
        <ContentTemplate>
            <ajaxToolkit:TabContainer runat="server" ID="tabVehicleStatus" Height="400px" ActiveTabIndex="2"
                CssClass="ajax__tab_msngallery-theme" Width="100%">
                <ajaxToolkit:TabPanel runat="server" ID="Panel1" HeaderText="Vehicle Settings">
                    <ContentTemplate>
                        <asp:Table ID="Table2" runat="server" CellSpacing="1" CellPadding="3" Width="600px"
                            class="boxbg" border="0">
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Vehicle Selection </font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Vehicle_Select"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Vehicle Filter</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Vehicle_Filter"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Currnet Location" Value="CUR_LOC"></asp:ListItem>
                                        <asp:ListItem Text="Contrlling Location" Value="CONT_LOC"></asp:ListItem>
                                        <asp:ListItem Text="None" Value="NONE"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Vehicle Mode Required</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Vehicle_Mode"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Tripsheet with valid vehicle</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_TS_Valid_Vehicle"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                <ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="Driver Settings">
                    <ContentTemplate>
                        <asp:Table ID="Table4" runat="server" CellSpacing="1" CellPadding="3" Width="600px"
                            class="boxbg" border="0">
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Driver Selection</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Driver1_Manual"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Driver without vehicle(In Tripsheet)</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Driver_WO_Vehicle"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                <ajaxToolkit:TabPanel runat="server" ID="tabVehicleInfo" HeaderText="Other Settings">
                    <HeaderTemplate>
                        Other Settings
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:Table ID="is2" runat="server" CellSpacing="1" CellPadding="3" Width="600px"
                            class="boxbg" border="0">
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Auto generated Manual Tripsheet No</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Manual_TSNo" 
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Trip Route Selection</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Route" 
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Both" Value="B"></asp:ListItem>
                                        <asp:ListItem Text="City Wise" Value="C"></asp:ListItem>
                                        <asp:ListItem Text="Route Wise" Value="R"></asp:ListItem>
                                        <asp:ListItem Text="None" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Fuel Bill Entry Tripsheet Number Wise</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Fuel_Bill_Entry_TSWise" 
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">THC Attached </font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_THC" 
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">UFL Filter</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_UFL_Filter"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">THC Without Tripsheet</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_THC_WO_Tripsheet"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Local City Allowed (To City can be equal to From City ?)</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Local_City"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                             <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Checklist Module Required</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Checklist"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Checklist Mandatory in Trip Sheet</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Checklist_Mandatory"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            
                             <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Trip Sheet Generation Not Allowed For Driver</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:CheckBox ID="Chk_Driver_Photo" runat="server" Text="Driver photo not uploaded"  />
                                    <br>
                                     <asp:CheckBox ID="Chk_Driver_License" runat="server" Text="Driver�s License expired" />
                                     <br>
                                      <asp:CheckBox ID="Chk_Settlement_Pending" runat="server" />Settlement pending more than
                                      <asp:TextBox ID="txtTripsheetNo" runat="server" Width="20px" BorderStyle="Groove" onkeypress="javascript:return validInt(event);" 
                                           MaxLength="2" CssClass="input"></asp:TextBox> Trip Sheet 
                                 <br>
                                </asp:TableCell>
                            </asp:TableRow>
                            
                        </asp:Table>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                <ajaxToolkit:TabPanel runat="server" ID="tabOtherInfo" HeaderText="Docket Settings">
                    <ContentTemplate>
                        <asp:Table ID="id3" runat="server" CellSpacing="1" CellPadding="3" Width="600px"
                            class="boxbg" border="0">
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">External Usages Category</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_External_Usages_Cat"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Attched Docket Number With Tripsheet</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Attached_Docket"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Docket Number Lable</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:TextBox ID="tb_Docket_Number_Text"
                                        CssClass="input" BorderStyle="Groove" runat="server"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
            </ajaxToolkit:TabContainer>
            <%--  <asp:TableRow style="background-color: white">
                <asp:TableCell  Width="40%"   HorizontalAlign="Left">
                     <font class="bluefnt">Driver 2 Manual Code Enter</font>
                </asp:TableCell>
                <asp:TableCell Width="60%"   HorizontalAlign="Left">
                    <asp:RadioButtonList ID="rb_Driver2_Manual" RepeatDirection="Horizontal" runat="server">
                        <asp:ListItem Text="Y" Value="Y" ></asp:ListItem>  
                        <asp:ListItem Text="N" Value="N" ></asp:ListItem>  
                    </asp:RadioButtonList>
                </asp:TableCell>  
            </asp:TableRow>--%>
            <%--   <asp:TableRow style="background-color: white">
                <asp:TableCell  Width="40%"   HorizontalAlign="Left">
                     <font class="bluefnt">Vehicle with controlling branch(In Tripsheet)</font>
                </asp:TableCell>
                <asp:TableCell Width="60%"  HorizontalAlign="Left">
                    <asp:RadioButtonList ID="rb_TS_VehicleFilter_Loc" 
                        RepeatDirection="Horizontal" runat="server">
                        <asp:ListItem Text="Yes" Value="Y" ></asp:ListItem>  
                        <asp:ListItem Text="No" Value="N" ></asp:ListItem>  
                    </asp:RadioButtonList>
                </asp:TableCell>  
            </asp:TableRow>--%>
            <%--              <asp:TableRow Style="background-color: white">
                            <asp:TableCell ColumnSpan="2" Width="100%">
                            </asp:TableCell>
                        </asp:TableRow>
                        </asp:Table>--%>
            <asp:Label runat="server" ID="lbl_Page_Err" Text=""></asp:Label>
            
       <tr bgcolor="white">
        <td class="blackfnt" colspan="3" style="vertical-align: middle; text-align: center; height: 25px;">
            <asp:Button ID="cmdSubmit"  runat="server" Text="Submit >>" OnClientClick="javascript:return SubmitData()" OnClick="SubmitData" />
        </td>
        </tr>
            
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
