<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TripRuleMaster.aspx.cs" Inherits="GUI_Fleet_TripRuleMaster_TripRuleMaster" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
     <link id="Link3" href="~/GUI/images/TabStyleSheet.css" rel="Stylesheet" type="text/css" runat="server" />
     <script type="text/javascript" language="javascript" src="../../images/commonJs.js" ></script>
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
        var txtTripsheetNo = document.getElementById("tabVehicleStatus_TabPanel1_txtTripsheetNo");
        var Chk_Settlement_Pending = document.getElementById("tabVehicleStatus_TabPanel1_Chk_Settlement_Pending");
        
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
</head>
<body>

    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
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
    <%-- <asp:Table ID="Table1" runat="server" CellSpacing="1" Width="500px">
        <asp:TableRow Style="background-color: white">
            <asp:TableCell HorizontalAlign="left" Width="50%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server" Text="Trip Rule Master" />
            </asp:TableCell>
            <asp:TableCell Width="50%" HorizontalAlign="Right">
                       
               
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>--%>
    <asp:UpdatePanel runat="server" ID="UpPanel">
        <ContentTemplate>
            <ajaxToolkit:TabContainer runat="server" ID="tabVehicleStatus" Height="400px" ActiveTabIndex="0"
                CssClass="ajax__tab_technorati-theme" Width="1100px">
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
                <ajaxToolkit:TabPanel runat="server" ID="tabVehicleInfo" HeaderText="Other Settings">
                    <HeaderTemplate>
                        Other Settings
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:Table ID="is2" runat="server" CellSpacing="1" CellPadding="3" Width="850px"
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
                     <font class="bluefnt">Trip Start KM Reading Should be</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Start_KM_Reading"
                                        RepeatDirection="Vertical" runat="server">
                                        <asp:ListItem Text="Retrieved from last Trip or Not" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="Not to be changed" Value="N"></asp:ListItem>
                                        <asp:ListItem Text="Editable and can be changed up to current km + 500 km" Value="Z"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Trip Close KM Reading Should be</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Close_KM_Reading"
                                        RepeatDirection="Vertical" runat="server">
                                        <asp:ListItem Text="Difference between close km & start km should not be greater than 10000 km" Value="Y" Selected="False"></asp:ListItem>
                                        <asp:ListItem Text="Always be greater than start km" Value="N" Selected="False"></asp:ListItem>
                                    </asp:RadioButtonList>
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
                     <font class="bluefnt">Docket Number Label</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:TextBox ID="tb_Docket_Number_Text"
                                        CssClass="input" BorderStyle="Groove" runat="server"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                 <ajaxToolkit:TabPanel runat="server" ID="tabEexpenceRuleCheck" HeaderText="Expense Rule Check">
                    <ContentTemplate>
                        <asp:Table ID="Table1" runat="server" CellSpacing="1" CellPadding="3" Width="600px"
                            class="boxbg" border="0">
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Trip closure should not be submitted if total expense (en-route + diesel) should</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Trip_Colsure"
                                        RepeatDirection="Vertical" runat="server">
                                        <asp:ListItem Text="Not be equals to ZERO" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="be equals to ZERO" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">In fuel bill entry, slip date should be</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                  <%--  <asp:RadioButtonList ID="rb_Fuel_Bill_Entry"
                                        RepeatDirection="Vertical" runat="server">
                                        <asp:ListItem Text="Greater than/equals to trip date" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="Less than/equals to trip close date" Value="N"></asp:ListItem>
                                        <asp:ListItem Text="Less than/equals to settlement date" Value="Z"></asp:ListItem>
                                    </asp:RadioButtonList>--%>
                                    <asp:CheckBox ID="Chk_Trip_Date" runat="server" Text="Greater than/equals to trip date"  />
                                    <br>
                                    <asp:CheckBox ID="Chk_TripDate_Close_Date" runat="server" Text="Less than/equals to trip close date" Enabled="false"/>
                                    <br>
                                    <asp:CheckBox ID="Chk_TripDate_Settlmnt_Date" runat="server" Text="Less than/equals to settlement date" Enabled="false"/>
                                 <br>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                 <ajaxToolkit:TabPanel runat="server" ID="TabPanel2" HeaderText="Advance payment check">
                    <ContentTemplate>
                        <asp:Table ID="Table3" runat="server" CellSpacing="1" CellPadding="3" Width="600px"
                            class="boxbg" border="0">
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Advance entry can be allowed</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_Advance_Entry"
                                        RepeatDirection="Vertical" runat="server">
                                        <asp:ListItem Text="Till the settlement not done" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="Till the trip sheet not closed" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                 <ajaxToolkit:TabPanel runat="server" ID="TabPanel3" HeaderText="Document Nomenclature">
                    <ContentTemplate>
                        <asp:Table ID="Table5" runat="server" CellSpacing="1" CellPadding="3" Width="600px"
                            class="boxbg" border="0">
                           <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Document Name Setting Trip Sheet</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:TextBox ID="txtTripSheet"
                                        CssClass="input" BorderStyle="Groove" runat="server"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Document Name Setting Job Sheet</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:TextBox ID="txtJobsheet"
                                        CssClass="input" BorderStyle="Groove" runat="server"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                <ajaxToolkit:TabPanel runat="server" ID="TabPanel4" HeaderText="Back Date Rule">
                    <ContentTemplate>
                        <asp:Table ID="Table6" runat="server" CellSpacing="1" CellPadding="3" Width="600px"
                            class="boxbg" border="0">
                          <%-- <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="43%" HorizontalAlign="Left">
                     <font class="bluefnt">Trip Sheet Date Rule</br>(Allowed up to 7 days from today's date)</font>
                                </asp:TableCell>
                                <asp:TableCell Width="47%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_TripSheet_DateRule"
                                        RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Trip Advance Date Rule</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                     <asp:RadioButtonList ID="rb_TripAdvance_DateRule"
                                        RepeatDirection="Vertical" runat="server">
                                        <asp:ListItem Text="Allowed up to 3 days from today's date" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="Less than/equals to trip sheet date" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>--%>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell Width="40%" HorizontalAlign="Left">
                     <font class="bluefnt">Driver Settlement Date Rule</font>
                                </asp:TableCell>
                                <asp:TableCell Width="60%" HorizontalAlign="Left">
                                    <asp:RadioButtonList ID="rb_DriverSettlement_DateRule"
                                        RepeatDirection="Vertical" runat="server">
                                        <asp:ListItem Text="Allowed up to Specified days from today's date" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="Greater Than Equals to Trip Close Date�" Value="N"></asp:ListItem>
                                        <asp:ListItem Text="Greater Than Equals to Last Advance Date" Value="Z"></asp:ListItem>
                                    </asp:RadioButtonList>
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
        
    </div>
    </form>
</body>
</html>
