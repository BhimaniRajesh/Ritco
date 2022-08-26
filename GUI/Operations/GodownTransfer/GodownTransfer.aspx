<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" 
    CodeFile="GodownTransfer.aspx.cs" Inherits="GodownTransfer" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy_Location_Wise_GodownDetail.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">        
        var cal = new CalendarPopup("divDate");        
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();        
    </script>

    <script language="JavaScript" type="text/javascript">
/*************************************************************************************************************
*   DATA VALIDATION FOR BUTTON SUBMIT
/*************************************************************************************************************/        
var Frm_Name="ctl00_MyCPH1_";
 
function btnsubmitClick()
{
//    debugger
//    if(checkBoxClick() == false)
//           alert("please select one record for update");
           
    var txtFromDate = document.getElementById(Frm_Name+'txtFromDate');
    var txtToDate = document.getElementById(Frm_Name+'txtToDate');  
//    var ddlPaybase = document.getElementById(Frm_Name+'ddlPaybase');
//    var ddlMode = document.getElementById(Frm_Name+'ddlMode');   
    
  
    if (document.getElementById("ctl00_MyCPH1_Fromlc_cboLO").value == "All")
    {
         alert("Please select atleat One Locaiton");
         document.getElementById("ctl00_MyCPH1_Fromlc_cboLO").focus();
         return false;
    }   
    
//    
//    if (txtToDate.value == "")
//    {
//         alert("Please enter to date.");
//         txtToDate.focus();
//         return false;
//    }    
//    if (ddlPaybase.value == "0")
//    {
//         alert("Please select paybase.");
//         ddlPaybase.focus();
//         return false;
//    }
//    
//    if (ddlMode.value == "0")
//    {
//         alert("Please select mode.");
//         ddlMode.focus();
//         return false;
//    }       
//        var gvRoute = document.getElementById("ctl00_MyCPH1_gvDocketInfo"); 
//        var rows, Prefix, chkSelect, ddlNewGodown;   
//    
//        if(gvRoute != null)
//        {
//              rows = gvRoute.rows.length;                  
//            
//              for(i=1;i<rows;i++)
//              {
//                   if (i<10)                                               
//                        Prefix = "ctl00_MyCPH1_gvDocketInfo_ctl0"+ i;           
//                   else                   
//                        Prefix = "ctl00_MyCPH1_gvDocketInfo_ctl"+ i;            
//                                       
//                   chkSelect = document.getElementById(Prefix +"_chkSelect");
//                   ddlNewGodown = document.getElementById(Prefix +"_ddlNewGodown"); 
//                                         
//                   if(chkSelect != null)
//                   {
//                       if (chkSelect.checked) 
//                       {                   
//                            if(ddlNewGodown.value == "0")
//                            {
//                                alert("Select New Godown.");
//                                ddlNewGodown.focus();
//                                return false;
//                            }
//                       }                  
//                   }                
//              }                
//         } 
    return true;            
}

/*************************************************************************************************************
*   VALIDATION FOR DATE : dd/mm/yyyy Format
/*************************************************************************************************************/        
function checkDate(id, strCaption)
{
    var obj = document.getElementById(id);      
    obj.value = obj.value.toUpperCase(); 
    
       if (obj.value != "")
       {
        if (!isValidDate(obj.value, strCaption))
        {
            obj.value = "";
            obj.focus();
            return false;
        }
    }       
}  

// SELECT ATLEAST ONE RECORD FOR UPDATE
function checkBoxClick()
{
    var gvRoute = document.getElementById("ctl00_MyCPH1_gvDocketInfo"); 
    var rows, Prefix, chkSelect, ddlNewGodown;
    var flag = false;
    
        if(gvRoute != null)
        {
              rows = gvRoute.rows.length;                  
            
              for(i=0;i<rows;i++)
              {
                   j = i+1;             
              
                   if (j<10)
                   {                                
                        Prefix = "ctl00_MyCPH1_gvDocketInfo_ctl0"+ j;                               
                   }
                   else
                   { 
                        Prefix = "ctl00_MyCPH1_gvDocketInfo_ctl"+ j;                                             
                   }
                                       
                   chkSelect = document.getElementById(Prefix +"_chkSelect");
                   ddlNewGodown = document.getElementById(Prefix +"_ddlNewGodown"); 
                                         
                   if(chkSelect != null)
                   {
                       if (chkSelect.checked)
                       {
                          ddlNewGodown.disabled = false;
                          
                           if(ddlNewGodown.value == "0")
                           {
                                alert("Select New Godown.");
                                ddlNewGodown.focus();
                                return false;
                           }
                            
                          flag = true;
                       } 
                       else
                       {
                           ddlNewGodown.disabled = true;
                       }
                   }                
              }    
                   
               if(flag)
               {
                   return flag;
               }             
               else 
               {
                   alert("please select atleast one record for update");
                   return false;
               }
         }    
}  

function checkBoxStatus()
{
    var gvRoute = document.getElementById("ctl00_MyCPH1_gvDocketInfo"); 
    var rows, Prefix, chkSelect, ddlNewGodown;   
    
        if(gvRoute != null)
        {
              rows = gvRoute.rows.length;                  
            
              for(i=0;i<rows;i++)
              {
                   j = i+1;             
              
                   if (j<10)
                   {                                
                        Prefix = "ctl00_MyCPH1_gvDocketInfo_ctl0"+ j;                               
                   }
                   else
                   { 
                        Prefix = "ctl00_MyCPH1_gvDocketInfo_ctl"+ j;                                             
                   }
                                       
                   chkSelect = document.getElementById(Prefix +"_chkSelect");
                   ddlNewGodown = document.getElementById(Prefix +"_ddlNewGodown"); 
                                         
                   if(chkSelect != null)
                   {
                       if (chkSelect.checked)
                       {
                          ddlNewGodown.disabled = false;                         
                       } 
                       else
                       {
                           ddlNewGodown.disabled = true;
                       }
                   }                
              }                
         }    
} 
    </script>

    <br />
      <div align="center">
                        <asp:UpdateProgress ID="uppMain" runat="server">
                            <ProgressTemplate>
                                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                    <tr>
                                        <td align="right">
                                            <img src="./../../images/loading.gif" alt="" />
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
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Panel runat="server" HorizontalAlign="center" Style="width: 10in" ID="pnlMain">
                <br />
                <asp:Table ID="tblMain" runat="server" HorizontalAlign="center" CssClass="boxbg"
                    CellSpacing="1" BorderWidth="0" Width="100%" BorderStyle="Groove">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell HorizontalAlign="center" ColumnSpan="4" Font-Bold="true">
                    SELECT CRITERIA
                        </asp:TableCell>
                    </asp:TableRow>
                    <%-- <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" CssClass="blackfnt" Width="150px">                        
                                Date
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" CssClass="blackfnt" ColumnSpan="3">
                    From
                    <asp:TextBox ID="txtFromDate" CssClass="blackfnt" BorderStyle="Groove" runat="server" onkeypress="javascript:return validDate(event)" onblur="javascript:return checkDate(this.getAttribute('id'), 'From ')"
                        Width="86px" MaxLength="10"></asp:TextBox><a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtFromDate, 'alnktxtFromDate', 'dd/MM/yyyy'); return false;"
                            id="alnktxtFromDate">&nbsp<img src="../../../GUI/images/calendar.jpg" border="0"
                                alt="" />
                        </a>&nbsp; To
                    <asp:TextBox ID="txtToDate" CssClass="blackfnt" BorderStyle="Groove" runat="server" onkeypress="javascript:return validDate(event)" onblur="javascript:return checkDate(this.getAttribute('id'), 'To ')"
                        Width="86px" MaxLength="10"></asp:TextBox><a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtToDate, 'alnktxtToDate', 'dd/MM/yyyy'); return false;"
                            id="alnktxtToDate">&nbsp<img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                        </a>
                </asp:TableCell>
            </asp:TableRow>--%>
                    <asp:TableRow CssClass="bgwhite" ID="TableRow2" runat="server">
                        <asp:TableCell VerticalAlign="Top" HorizontalAlign="Left" CssClass="blackfnt">                   
                   Location</asp:TableCell>
                        <asp:TableCell VerticalAlign="Top" HorizontalAlign="left">
                            <Location:LH ID="Fromlc" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="TableRow1" runat="server">
                        <asp:TableCell VerticalAlign="Top" HorizontalAlign="Left" CssClass="blackfnt">                   
                    Pay Base</asp:TableCell>
                        <asp:TableCell VerticalAlign="Top" HorizontalAlign="left">
                            <asp:DropDownList ID="ddlPaybase" runat="server" CssClass="blackfnt" Width="125px"
                                TabIndex="4">
                                <asp:ListItem Selected="True" Text="Select" Value="">
                                </asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="Tr_Route_Typ" runat="server">
                        <asp:TableCell VerticalAlign="Top" HorizontalAlign="Left" CssClass="blackfnt">                   
                   Mode </asp:TableCell>
                        <asp:TableCell VerticalAlign="Top" HorizontalAlign="left">
                            <asp:DropDownList ID="ddlMode" runat="server" CssClass="blackfnt" Width="125px" TabIndex="4">
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="TableRow3" runat="server">
                        <asp:TableCell VerticalAlign="Top" HorizontalAlign="Left" CssClass="blackfnt">                   
                   As On Date </asp:TableCell>
                        <asp:TableCell VerticalAlign="Top" HorizontalAlign="left">
                            <asp:TextBox ID="txtFromDate" Width="60" MaxLength="10" runat="server"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtFromDate,'anchor45','dd/MM/yyyy'); return false;"
                                name="anchor45" id="a45">
                                <img src="./../../images/calendar.jpg" id="i2" runat="server" border="0" />
                            </a>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell VerticalAlign="Top" HorizontalAlign="Center" ColumnSpan="4">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="blackfnt" TabIndex="6"
                                OnClientClick="javascript:return btnsubmitClick();" OnClick="btnSubmit_Click" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell Height="20px" ColumnSpan="4">                   
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="trGrid" runat="server">
                        <asp:TableCell Height="20px" ColumnSpan="4">
                            <asp:GridView ID="gvDocketInfo" BorderWidth="0" CellSpacing="1" runat="server" AutoGenerateColumns="false"
                                Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="bgwhite"
                                PagerSettings-Mode="NumericFirstLast" PageSize="10" OnRowDataBound="gvDocketInfo_RowDataBound"
                                SelectedIndex="1" EmptyDataText="No record found.....">
                                <Columns>
                                    <asp:TemplateField HeaderText="Select" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelect" CssClass="blackfnt" runat="server" onclick="Javascript:return checkBoxStatus();" />
                                            <%--onclick="Javascript:return checkBoxClick();"--%>
                                            <asp:HiddenField ID="hdfDockNo" runat="server" Value='<%# DataBinder.Eval( Container.DataItem,"dockno") %>' />
                                            <asp:HiddenField ID="hdfGodownSrNo" runat="server" Value='<%# DataBinder.Eval( Container.DataItem,"GODOWN") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Docket No" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblDocketNo" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockno") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Date" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblDate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockdt") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Origin" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblOrigin" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Orgncd") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Destination" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblDestination" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"reassign_destcd") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Current Loc" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblLoc" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Curr_loc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Paybase" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblPaybase" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"PaybaseDesc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Route Mode" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblMode" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"RouteMode") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="GoDown" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblGoDown" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Godown_desc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="New GoDown" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlNewGodown" Enabled="false" CssClass="blackfnt" runat="server">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgbluegrey" ID="trBtnUpdate" runat="server">
                        <asp:TableCell VerticalAlign="Top" HorizontalAlign="Center" ColumnSpan="4">
                            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="blackfnt" TabIndex="6"
                                OnClick="btnUpdate_Click" OnClientClick="Javascript:return checkBoxClick();" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgbluegrey" ID="trlblMsg" runat="server">
                        <asp:TableCell VerticalAlign="Top" HorizontalAlign="Center" ColumnSpan="4">
                            <asp:Label ID="lblMsg" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
