<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"   CodeFile="CloseJobOrder_UsingSM.aspx.cs" Inherits="GUI_Fleet_Job_CloseJobOrder" %>
<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
<script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>
<script type="text/javascript" language="javascript" src="../../Js/querystring.js" ></script>
<script language="javascript" type="text/javascript" src="AJAX_Validator/CloseJobSheet.js"> </script>
<script language="javascript" type="text/javascript">
    
    var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");

    var FinYear="<%=Session["FinYear"]%>"
    var FinYear_to=parseInt(FinYear)+1
		
    if(FinYear_to<10)
    {
        FinYear_to="0"+FinYear_to
    }
    var FinYear_fromdate="01/04/"+FinYear
    var FinYear_todate="31/03/"+FinYear_to
    var Sle_finyear=FinYear+"-"+FinYear_to
     
</script>

   <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;layer-background-color: white; z-index: 99;">
    </div> 

<asp:UpdateProgress ID="UpdateProgress1" runat="server" >
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>
  
<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Close Job Order</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
                   <td align="right">
                <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  --%>
         
          </td>      
            
            
            
        </tr>
    </table>
    <br/>
    <br/>
    
<%--         <table cellspacing="1" width="95%" align="center">
       
                     <tr style="background-color: white" align="center">
                          <td  align="center"  >--%>
    
<asp:Table runat="server" >
    <asp:TableRow runat="server" ID="rowSM_Hdr" >
        <asp:TableCell>

         
    
        <table  align="center"  cellspacing="2" width="100%" >                                                                    
                     
        <tr  align="center"  style="background-color: white">

        <td align="left" >

                    
        <table  align="center" cellpadding="3"  cellspacing="2" width="100%" class="boxbg">                                                                    
                           
            <tr style="background-color: white">
                <td colspan="4" align="center">
                    <asp:Label ID="lblError" CssClass="redfnt" Visible="true" Font-Bold="true" runat="server"></asp:Label>
                </td>
            </tr>
                                          
                        
        <tr class="bgbluegrey">
            <td colspan="4" align="center">
                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Close Job Order</asp:Label>
            </td>
        </tr>
                           
                
                           
        <tr style="background-color: white">

            <td align="left" >
                <asp:Label ID="Label8" runat="server" CssClass="bluefnt"   Text="Job Order No."></asp:Label>
            </td>
            <td align="left" >&nbsp;
                <asp:DropDownList ID="ddlWONo" runat="server"   Width="120px"  AutoPostBack="true" CssClass="blackfnt" OnSelectedIndexChanged="ddlWONo_SelectedIndexChanged" >
                </asp:DropDownList>&nbsp;&nbsp;     
            </td>

            <td align="left" >
                <asp:Label ID="Label12" runat="server" Text="Job Order Date" CssClass="bluefnt"  ></asp:Label>
                &nbsp;
            </td>
            <td  align="left">
                &nbsp;<asp:Label ID="lblDate" runat="server" CssClass="blackfnt">
                </asp:Label>
            </td>

        </tr>
                           
                        
                           
                                          
                        <tr style="background-color: white">
               
                <td align="left" >
                    <asp:Label ID="Label4" runat="server" CssClass="bluefnt"   Text="Vehicle No."></asp:Label>
                                         
                </td>
                <td align="left" >&nbsp;
                <asp:Label ID="lblVehicleNo" runat="server" CssClass="blackfnt" >
                    </asp:Label>&nbsp;&nbsp;     
 
                    
                </td>
            
                                                       
                             <td align="left" >
                                 <asp:Label ID="Label1" runat="server" Text="Vehicle Category" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td  align="left">
                                &nbsp;<asp:Label ID="lblCategory" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                                                
                          <tr style="background-color: white" align="center">
                                                      
                             <td align="left"  >
                                 <asp:Label ID="Label2" runat="server" Text="Manufacturer" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblMfg" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                                                    
                                      <td align="left" >
                                 <asp:Label ID="Label3" runat="server" Text="Model" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblModel" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        
                        
                      
                        
                          <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label9" runat="server" Text="Job Card Type" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblOrderType" runat="server" CssClass="blackfnt">
                                     
                                 
                             </asp:Label>
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label11" runat="server" Text="Order Status" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblOrderStatus" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        
                        
                          <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label13" runat="server" Text="Vendor Type " CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblSCType" runat="server"  CssClass="blackfnt" >
                                                               
                             </asp:Label>
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="lblVendorHead" runat="server" Text="Vendor Name" CssClass="bluefnt" Visible="false"  ></asp:Label>
                              
                                <asp:Label ID="lblWLocHead" runat="server" Text="Workshop Location" CssClass="bluefnt" Visible="false"  ></asp:Label>
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblVendor" runat="server" CssClass="blackfnt" Visible="false">
                                                              </asp:Label>
                                                              <asp:Label ID="lblwLoc" runat="server" CssClass="blackfnt" Visible="false">
                                 
                             </asp:Label>
                                                              
                                                              
                                </td>
                             
                        </tr>
                        
                        
                        
                        
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label7" runat="server" Text="Send date to WorkShop " CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                            &nbsp;<asp:Label ID="LblSendDt" runat="server"  CssClass="blackfnt" ></asp:Label>
                                
                            </td>
                            
                             <td align="left"  >
                                 &nbsp;<asp:Label ID="Label14" runat="server" Text="Estimated return date " CssClass="bluefnt"  ></asp:Label>
                                </td>
                            <td align="left" >&nbsp;
                             <asp:Label ID="LblReturnDt" runat="server"  CssClass="blackfnt" ></asp:Label>
  
                            </td>
                        </tr>
                        
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label15" runat="server" Text="Actual Date of return " CssClass="bluefnt"  ></asp:Label>
                                </td>
                            <td align="left" colspan=3>
                                &nbsp;<%--<SControls:DateSelector ID="txtDCActRetrunDt_WS" runat="server" /> --%>
                                
                                 <asp:TextBox ID="txtDCActRetrunDt" runat="server" onblur="javascript:ValidateDate(this)"
                                BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDCActRetrunDt,'anchor22','dd/MM/yyyy'); return false;" id="a2" name="anchor22">
                                <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                            </td>
                        </tr>
                        
                        
                        <tr style="background-color: white" align="center">
                                                    
                            <td align="left" >
                                 <asp:Label ID="Label18" runat="server" Text="Starting KM Reading" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right">
                                &nbsp;<asp:Label ID="lblKMReading" runat="server" CssClass="blackfnt"  Width="100px"  style="text-align: right" ></asp:Label>
                             </td>
                             
                            <td align="left" >
                                 <asp:Label ID="Label17" runat="server" Text="Closing KM Reading" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right">
                                &nbsp;
                                <asp:TextBox ID="txtCloseKM" Text="0" style="text-align: right"      onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   runat="server"  Width="80px" CssClass="input" BorderStyle="Groove" ></asp:TextBox>
	                         
                                  <asp:RegularExpressionValidator ID="RegtxtCloseKM" runat="server"
                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                    ControlToValidate="txtCloseKM" Display="Dynamic"></asp:RegularExpressionValidator>   
                                
                             </td>

                        </tr>
                        </table>
                </asp:TableCell>
</asp:TableRow>
<asp:TableRow  runat="server" ID="rowNOSM_Hdr" >
<asp:TableCell>
    
   <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <table  align="center" cellpadding="3"  cellspacing="2" width="100%" class="boxbg">        
                        <tr class="bgbluegrey" align="center">
                                                    
                             <td align="center" colspan="2" >
                                    <asp:Label ID="Label16" Font-Bold="true"  runat="server" Text="Estimated Hrs and Cost" CssClass="bluefnt"  ></asp:Label>
                                
                             </td>
                             <td align="center" colspan="2" >
                                    <asp:Label ID="Label25"  Font-Bold="true"  runat="server" Text="Actual Hrs and Cost" CssClass="bluefnt"  ></asp:Label>
                                
                             </td>
                        </tr>
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label20" runat="server" Text="Total Estimated Labour Hrs" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right" >
                                &nbsp;<asp:Label ID="lbltotEstLHrs" runat="server" CssClass="blackfnt" Width="100px"  style="text-align: right"   >
                                    </asp:Label>
                                                              
                                </td>
                                    <td align="left" >
                                 <asp:Label ID="Label27" runat="server" Text="Total Part Quantity" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right" >
                                &nbsp;<asp:Label ID="lblPartQty" runat="server"   Width="100px" style="text-align: right" CssClass="blackfnt" >
                                 
                             </asp:Label>
                                              
                             
                                </td>    
                             
                        </tr>

                        
                        
                <tr style="background-color: white" align="center">

                    <%--<td align="left"  >
                        <asp:Label ID="Label5" runat="server" Text="Total Actual Labour Hrs" CssClass="bluefnt"  ></asp:Label>
                        &nbsp;
                    </td>
                    <td align="right" >
                        &nbsp;<asp:TextBox ID="txttotActLabHrs" runat="server" style="text-align: right"  Width="80px" CssClass="blackfnt"   ReadOnly="true"  BorderStyle="groove">
                        </asp:TextBox>
                    </td>--%>
                      <td align="left" >
                                 <asp:Label ID="Label22" runat="server" Text="Total Estimated Labour Cost" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right" >
                                &nbsp;<asp:Label ID="lbltotEstLCost" runat="server"   Width="100px" style="text-align: right" CssClass="blackfnt" >
                                 
                             </asp:Label>
                                              
                             
                                </td>
                   <td align="left" >
                        <asp:Label ID="Label10" runat="server" Text="Total Actual Labour Cost" CssClass="bluefnt"  ></asp:Label>
                        &nbsp;
                    </td>
                    <td align="right" >
                        &nbsp;<asp:TextBox ID="txttotActLabCost" BorderStyle="None"  style="text-align: right" Width="80px"  runat="server" ReadOnly="true"  CssClass="blackfnt"    >
                            </asp:TextBox>
                    </td>            
                                    
 
                   
                </tr>
                <tr style="background-color: white" align="center">
                    <td align="left"  >
                        <asp:Label ID="Label26"  runat="server" Text="Total Estimated Part Cost" CssClass="bluefnt"  ></asp:Label>
                    </td>
                    <td align="right" >
                        &nbsp;<asp:TextBox ID="txtEstimatedSparePart" BorderStyle="None" runat="server" style="text-align: right"  Width="80px" CssClass="blackfnt"  >
                        </asp:TextBox>
                    </td>
                    <td align="left"  >
                        <asp:Label ID="Label19" runat="server" Text="Total Actual Part Cost" CssClass="bluefnt"  ></asp:Label>
                    </td>
                    <td align="right" >
                        &nbsp;<asp:TextBox ID="txtActPartCost" BorderStyle="None"  runat="server" Text="0.00" style="text-align: right"  Width="80px" CssClass="blackfnt"    >
                        </asp:TextBox>
                    </td>
                </tr>
                        
                <tr style="background-color: white" align="center">
                                                    
                                               <td align="left"  >
                        <asp:Label ID="Label5" Font-Bold="true"  runat="server" Text="Total Estimated Cost" CssClass="bluefnt"  ></asp:Label>
                    </td>
                    <td align="right" >
                        &nbsp;<asp:TextBox ID="txtTotEstimatedCost" BorderStyle="None" runat="server" style="text-align: right"  Width="80px" CssClass="blackfnt"  >
                        </asp:TextBox>
                    </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label21" runat="server" Text="Total Actual Job Cost" CssClass="bluefnt" Font-Bold="true"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right" >
                                &nbsp;<asp:TextBox ID="txtJobCost"  BorderStyle="None" style="text-align: right" Width="80px" Font-Bold="true"   runat="server"  CssClass="blackfnt"   >
                                 
                             </asp:TextBox>
                             
                          
                                         
                                </td>
                             
                        </tr>
                          
                          
                          
                     </table>
                     <br/>
                     
        <asp:Panel ID="pnlTaskDet" runat="server" Width="100%" >          
    
        <table  cellspacing="1" width="85%"  class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td width="75%" >
                    <asp:Label ID="Label23" CssClass="blackfnt" Font-Bold="true" runat="server">Task Details</asp:Label>
                   
                </td>
                <td  align="left" width="15%">
                    <asp:Label  CssClass="blackfnt" ID="Label24" runat="server">Enter no. of rows </asp:Label>  
                </td>
                <td  width="5%" >
                     <asp:TextBox ID="txtTaskRow" runat="server"    onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  MaxLength="3" Width="30" BorderStyle="Groove"  AutoPostBack="true"  Text="0" OnTextChanged="txtTaskRow_TextChanged" ></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegtxtTaskRow" runat="server"
                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"  ValidationGroup="row"  
                        ControlToValidate="txtTaskRow" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
                <td  width="5%">
                    <asp:Label ID="lblTaskL" runat="server" Font-Bold="True">Show...</asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>


                    <%-- <table cellspacing="1" width="100%"  class="boxbg">
                     
                     
                             <tr class="bgbluegrey"  >
                        <td  align="center" colspan=2>
                            <asp:Label ID="Label6" CssClass="blackfnt" Font-Bold="true" runat="server">Task Details</asp:Label>
                        </td>
                    </tr>
                                   
             
                <tr align="center" style="background-color:White">
                    <td  align="left" width="20%"   >
                        <asp:Label  CssClass="bluefnt" ID="Label16" runat="server">Enter no. of rows </asp:Label>&nbsp;&nbsp;
                        </td>
                        <td align="left" >
                        <asp:TextBox ID="txtTaskRow" runat="server"    onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  MaxLength="3" Width="30" BorderStyle="Groove"  AutoPostBack="true"  Text="0" OnTextChanged="txtTaskRow_TextChanged" ></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegtxtTaskRow" runat="server"
                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"  ValidationGroup="row"  
                        ControlToValidate="txtTaskRow" Display="Dynamic"></asp:RegularExpressionValidator>
                    </td>
                </tr>
          </table>--%>
    
       
    
     <table cellspacing="1" width="100%">
       
            
     
        <tr align="center">
            <td align="center">
         
         
                     
            <tr align="center"   >
              <td align="center">
                 <asp:Panel ID="pblTask" runat="server" >
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True"  OnRowDataBound="GridView1_RowDataBound"
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            PageSize="10"   >
                            <Columns>
                                
                                <asp:TemplateField HeaderText="Select">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  />
                                    <ItemTemplate>
                                       <asp:CheckBox ID="chk_Flag" runat="server" Checked="True" onclick="javascript:checkme() " />
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center"  VerticalAlign="Top" />
                                </asp:TemplateField>
                                
                                
                                 <asp:TemplateField HeaderText="Work Group" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left" >
	                                <ItemTemplate >
                                        <asp:Label ID="lblW_GRPCD"  runat="server" CssClass="blackfnt" ></asp:Label>
                                        <asp:DropDownList ID="ddlWorkGroup" runat="server"   Width="150px" AutoPostBack="true"  CssClass="blackfnt" OnSelectedIndexChanged="ddlWorkGroup_SelectedIndexChanged"  Visible="false"></asp:DropDownList> 
	                                </ItemTemplate>
	                              </asp:TemplateField>
                                
                                
                                 <asp:TemplateField HeaderText="Task Code " visible="false">
	                                <ItemTemplate>
	                                    <asp:Label ID="lblTaskCode" runat="server" CssClass="blackfnt" ></asp:Label>
	                         	    </ItemTemplate>
	                              </asp:TemplateField>
	                              
                                <asp:TemplateField HeaderText="Task Description"  HeaderStyle-Wrap="false" ItemStyle-Wrap="false"  HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left" >
                                    <ItemTemplate>
                                    <%--AutoPostBack="true"  OnSelectedIndexChanged="ddlTask_SelectedIndexChanged" --%>
                                        <asp:Label ID="lblTaskDesc"       runat="server"    CssClass="blackfnt"  ></asp:Label>
                                        <asp:DropDownList ID="ddlTask" runat="server"   Width="350px" CssClass="blackfnt"  Visible="false"></asp:DropDownList>                 
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Task Type" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left" >
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTaskType"    runat="server"  BorderStyle="None" CssClass="blackfnt"   />
                                    </ItemTemplate>
                                </asp:TemplateField>
	                              
                                <asp:TemplateField HeaderText="Remark" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblRemark"      runat="server"      CssClass="blackfnt"  ></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                
                                <asp:TemplateField HeaderText="Action Taken" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left" >
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtAction"    runat="server"  Width="100px" CssClass="input" BorderStyle="Groove"   ></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
	                              
	                              
                               <%-- <asp:TemplateField HeaderText="Completion Date(dd/mm/yyyy)" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left" >
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtComplDate"    runat="server"  Width="80px" CssClass="input" BorderStyle="Groove" maxlength="10"  ></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegtxtComplDate" runat="server"
                                        ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))" SetFocusOnError="true"
                                        ControlToValidate="txtComplDate" Display="Dynamic"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                                </asp:TemplateField>--%>

                                <asp:TemplateField HeaderText="Est. Labour Hours"  HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Right" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblEstHrs"      runat="server"      CssClass="blackfnt"  ></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
	                              
	                              
                                <asp:TemplateField HeaderText="Est. Labour Cost" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Right" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblEstCost" runat="server"      CssClass="blackfnt"  ></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                              
                                <asp:TemplateField HeaderText="AMC/Non AMC" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Right" >
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlAMC"  runat="server">
                                            <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                            <asp:ListItem Text="AMC" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Non AMC" Value="1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>    
                                </asp:TemplateField>
                              
	                          <%--  <asp:TemplateField HeaderText="Actual Labour Hours" Visible="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Right" >
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtEstHrs" Text="0" style="text-align: right"     onblur="javascript:return calculate()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   runat="server"  Width="80px" CssClass="input" BorderStyle="Groove" OnTextChanged="txtEstHrs_TextChanged"   ></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegtxtEstHrs" runat="server"
                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                        ControlToValidate="txtEstHrs" Display="Dynamic"></asp:RegularExpressionValidator>                           
	                                </ItemTemplate>
	                            </asp:TemplateField>--%>
	                              
	                            <asp:TemplateField HeaderText="Actual Labour Cost" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Right" >
	                                    <ItemTemplate>
                                            <asp:TextBox ID="txtActualLabourCost" style="text-align: right"   Text="0"  runat="server"  onblur="javascript:return calculate()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   Width="80px" CssClass="input" BorderStyle="Groove"  ></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                            ControlToValidate="txtActualLabourCost" Display="Dynamic"></asp:RegularExpressionValidator>                             
	                                    </ItemTemplate>
	                              </asp:TemplateField>
                        
   
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                         </asp:Panel>

                        <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender3" runat="Server"
                        TargetControlID="pblTask"
                        CollapsedSize="0"
                        Collapsed="True"
                        ExpandControlID="pnlTaskDet"
                        CollapseControlID="pnlTaskDet"
                        AutoCollapse="False"
                        AutoExpand="False"
                        TextLabelID="lblTaskL"
                        CollapsedText="Show..."
                        ExpandedText="Hide..." 
                        ExpandDirection="Vertical" />
                   
            </td>
        </tr> 
    </table>
    <br/>
        <asp:Panel ID="tblSpare" runat="server" Width="100%" >          
    
        <table  cellspacing="1" width="85%"  class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td width="75%" >
                    <asp:Label ID="lblHead" CssClass="blackfnt"  Font-Bold="true" runat="server">Spare Part-Requirements(Estimates)</asp:Label>
                   
                </td>
                <td  align="left" width="15%">
                    <asp:Label  CssClass="blackfnt" ID="lblRow" runat="server">Enter no. of rows </asp:Label>  
                </td>
                <td  width="5%" >
                      <asp:TextBox ID="txtRow" runat="server"    onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  MaxLength="3" Width="30" BorderStyle="Groove"  AutoPostBack="true"  Text="0" OnTextChanged="txtRow_TextChanged" ></asp:TextBox>
              	            <asp:RegularExpressionValidator ID="RegtxtRow" runat="server"
                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"  ValidationGroup="row"  
                            ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
                <td  width="5%">
                    <asp:Label ID="lblTDSH" runat="server" Font-Bold="True">Show...</asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    
     <table cellspacing="1" width="100%">
        <tr align="center">
            <td align="center">
                             
            <asp:Panel ID="pnlSpare" runat="server" >
            <asp:DataGrid ID="dgSpare" runat="server"    
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" width="100%"
                            HeaderStyle-CssClass="dgHeaderStyle"  PagerStyle-HorizontalAlign="left" OnItemDataBound="dgSpare_ItemDataBound"
                             >
                            <Columns>
               
               
                                                 <asp:TemplateColumn HeaderText="Sr.No." HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                            <ItemTemplate >
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
               
               

                            <asp:TemplateColumn HeaderText="Work Group" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left" >
                                <ItemTemplate >
                                    <asp:DropDownList ID="ddlWorkGroup" runat="server"   Width="150px" AutoPostBack="true"  CssClass="blackfnt" OnSelectedIndexChanged="ddlWorkGroup_SelectedIndexChanged"  Visible="false"></asp:DropDownList> 
                                    <asp:Label ID="lblW_GRPCD" runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:TemplateColumn>
                                
	                              
                            <asp:TemplateColumn HeaderText="Part Description" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
	                                <ItemTemplate>
	                               
	                              <asp:DropDownList ID="ddlPartNo" runat="server"  Width="200px"  CssClass="blackfnt"   OnSelectedIndexChanged="ddlPartNo_SelectedIndexChanged" AutoPostBack=true >
	                              <%--<asp:ListItem Text="Select" Value=""></asp:ListItem>--%>
	                              </asp:DropDownList>
	                            
	                                </ItemTemplate>
	                                <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
	                              </asp:TemplateColumn>
	                              
	                              

                                        <%--<asp:TemplateColumn HeaderText="Part Description" >
                                        <ItemTemplate>

                                        <asp:DropDownList ID="ddlPDesc" runat="server" Width="150px" CssClass="blackfnt"   ></asp:DropDownList>

                                        </ItemTemplate>
                                        </asp:TemplateColumn>--%>
	                                    <asp:TemplateColumn HeaderText="Quantity" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
	                                <ItemTemplate>
	                               
	                              <asp:TextBox ID="txtQty" Width="75px" runat="server"  style="text-align: right"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))" onkeydown="return numeric(event)"  CssClass="blackfnt" BorderStyle="Groove" onblur="javascript:return calculateSpare()"     ></asp:TextBox><%--AutoPostBack="true"  OnTextChanged="txtQty_TextChanged"--%>
	                              <asp:RequiredFieldValidator ID="reqtxtQty"   ValidationGroup="G1"   runat="server" Display="Dynamic" Text="!" ControlToValidate="txtQty"></asp:RequiredFieldValidator>
	                                <asp:RegularExpressionValidator ID="RegtxtQty" runat="server"
                                    ErrorMessage="!" ValidationExpression="^\d{0,9}$" SetFocusOnError="true"
                                    ControlToValidate="txtQty" Display="Dynamic"></asp:RegularExpressionValidator>                    
	                            
	                                </ItemTemplate>
	                                        <HeaderStyle HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
	                              </asp:TemplateColumn>
	                              
	                              
	                            <asp:TemplateColumn HeaderText="Cost/Unit" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
	                                <ItemTemplate>
	                                    <asp:Label ID="lblCostUnit" runat="server"  width="120px" CssClass="blackfnt"   ></asp:Label>
	                                </ItemTemplate>
	                                        <HeaderStyle HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
	                              </asp:TemplateColumn>
	                              
	                            <asp:TemplateColumn HeaderText="Cost"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
	                                <ItemTemplate>
	                               
	                              <asp:TextBox ID="txtCost" runat="server" style="text-align: right"  ReadOnly="true"  width="75px" CssClass="blackfnt" BorderStyle="Groove"  ></asp:TextBox>
	                                <asp:RequiredFieldValidator ID="reqtxtCost"   ValidationGroup="G1"   runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCost"></asp:RequiredFieldValidator>
	                                </ItemTemplate>
	                                        <HeaderStyle HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
	                              </asp:TemplateColumn>
	                        
	                          
	                          
	                          
	                          
	                           <asp:TemplateColumn HeaderText="Remarks" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
	                                <ItemTemplate>
	                               
	                              <asp:TextBox ID="txtSpareRemark" runat="server"  Width="250px"  CssClass="blackfnt" BorderStyle="Groove"    ></asp:TextBox>
	                            
	                                </ItemTemplate>
	                                <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
	                              </asp:TemplateColumn>
  
                            </Columns>
                      
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:DataGrid>
                        
                        </asp:Panel>
                        <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server"
                        TargetControlID="pnlSpare"
                        CollapsedSize="0"
                        Collapsed="True"
                        ExpandControlID="tblSpare"
                        CollapseControlID="tblSpare"
                        AutoCollapse="False"
                        AutoExpand="False"
                        TextLabelID="lblTDSH"
                        CollapsedText="Show..."
                        ExpandedText="Hide..." 
                        ExpandDirection="Vertical" />
                       
            </td>
        </tr>
    </table>
    
      
    
    <br/>
    <asp:Panel ID="pnlSummaryHdr" runat="server" Width="70%" >          
    
        <table  cellspacing="1" width="100%"  class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td width="75%" >
                    <asp:Label ID="Label6" CssClass="blackfnt"  Height="20px"    Font-Bold="true" runat="server">Summary</asp:Label>
                   
                </td>
                
                <td  width="5%">
                    <asp:Label ID="lblSummaryHdr" runat="server" Font-Bold="True">Show...</asp:Label>
                </td>
            </tr>
        </table>
   
    </asp:Panel>
   <asp:Panel ID="pnlSummary" runat="server" Width="84%" >
         <asp:GridView ID="gvSummary" runat="server"    
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" width="100%"
                            HeaderStyle-CssClass="dgHeaderStyle"  PagerStyle-HorizontalAlign="left" >
                            <Columns>
                            <asp:BoundField DataField="W_GRPDESC" HeaderText="Work Group"></asp:BoundField>  
                            <asp:BoundField DataField="ACCDESC" HeaderText="Expense ledger "></asp:BoundField>  
                            <asp:BoundField DataField="TOT_LABOUR_COST" HeaderText="Labour Cost"></asp:BoundField>  
                            <asp:BoundField DataField="TOT_SPARE_COST" HeaderText="Spare Cost"></asp:BoundField>  
                            </Columns>
                        </asp:GridView>
               
      </asp:Panel>
                 <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender4" runat="Server"
                TargetControlID="pnlSummary"
                CollapsedSize="0"
                Collapsed="True"
                ExpandControlID="pnlSummaryHdr"
                CollapseControlID="pnlSummaryHdr"
                AutoCollapse="False"
                AutoExpand="False"
                TextLabelID="lblSummaryHdr"
                CollapsedText="Show..."
                ExpandedText="Hide..." 
                ExpandDirection="Vertical" />
            
       <table cellspacing="1" width="100%" align="">
                <tr style="background-color:White">
                   <td  align="center">
                     <asp:Button ID="cmdSubmit" runat="server" Text="Submit"  OnClientClick="javascript:return check()"    OnClick="cmdSubmit_Click"/> 
                    </td>
                </tr>
        
        </table>
    
    <br/>
      <center>
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
    </center>
    
    
    
    
    
    
    
                    </ContentTemplate>
                    <Triggers>
                     <asp:AsyncPostBackTrigger ControlID="ddlWONo" EventName="SelectedIndexChanged" />
                      <asp:AsyncPostBackTrigger ControlID="cmdSubmit" EventName="Click" />
                    
                    </Triggers>
                    </asp:UpdatePanel>
  
    
     <%-- </td>
        </tr>
        
        
        
     </table>--%>
     <br />

  </asp:TableCell>
</asp:TableRow>     
<asp:TableRow runat="server" ID="rowSM_Submit">
<asp:TableCell>

            <table cellspacing="1" width="100%" align="">
                <tr style="background-color:White">
                   <td  align="center">
                     <asp:Button ID="btnSubmitSM" runat="server" Text="Submit1"  OnClientClick="javascript:return checkSM()"    OnClick="cmdSubmitSM_Click"/> 
                    </td>
                </tr>
        
        </table>          
    </asp:TableCell>
</asp:TableRow>
</asp:Table>   
    </asp:Content>
 
