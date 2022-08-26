<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmViewPrintVehicleIssueSlip.aspx.cs" Inherits="Issue_frmViewPrintVehicleIssueSlip" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

 
                  
 

<head runat="server">
    <title>Trip Sheet</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    <script type="text/javascript" language="javascript" src="../../../Js/querystring.js" ></script>
 <script language="javascript">
    function printme()
    {
        var qs = new Querystring()
        var mPrintMode= qs.get("PrintMode");
        if(mPrintMode=="1")
        {
            window.print();
        }                      
    }
    function ViewPrint(mReqId)
    {
  	    var strurl="frmTripSheetDetails.aspx?id=" + mReqId;
        popup = window.open(strurl,"","height=475,width=850,scrollbars=yes,left=100,top=125");
    }
</script>
    
    
 
</head>
<html>

 









<%--<%if (PrintMode == "1")
  {
      tmpFont = "blackfnt";
      %>
    <body onload ="printme()">
    <%}
      else
      {
          tmpFont = "bluefnt";
      %> --%>
      <body onload="printme()">
 <%--   <%} %>--%>
    <form id="form1" runat="server">
   

    
    
    
    
    
    
    <div>
    

    
    
    
    
    <%
        
        string mydbcon = Session["SqlProvider"].ToString().Trim(); //System.Configuration.ConfigurationManager.AppSettings["dbConnection"];
        System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(mydbcon);
        
        conn.Open();
        string strVSlipNo = Request.QueryString["VSlipNo"].Trim();

        

        string sql = "select V.VSlipNo,Convert(varchar,VSlipDt,106) VSlipDt,VehicleNo,f_issue_startkm as Start_km,f_issue_fill "
                       + " ,(Select Manual_Driver_Code + ':' + Driver_Name from webx_fleet_drivermst where Driver_Id=v.driver1) As driver_name "
                       + " ,(Select License_no from webx_fleet_drivermst where Driver_Id=v.driver1) License_no "
                       + " ,(Select convert(varchar,valdity_dt,106) valdity_dt from webx_fleet_drivermst where Driver_Id=v.driver1) valdity_dt, "
                       + " isnull(f_closure_closekm,0)f_closure_closekm,isnull(f_closure_fill,0)f_closure_fill, "
                       + "isnull(Contractamt,0)Contractamt,isnull(c_Othercharg,0)c_Othercharg,isnull(c_TDSrate,0)c_TDSrate,isnull(c_TDSamt,0)c_TDSamt,c_TDStype,isnull(c_Advamt_paid,0)c_Advamt_paid,isnull(c_issue_tot,0)c_issue_tot, "
                       + "isnull(c_dedamt,0)c_dedamt,isnull(c_Balamt_paid,0)c_Balamt_paid,isnull(c_closure_tot,0)c_closure_tot,isnull(c_net_amt,0)c_net_amt,isnull(e_issue_advamt,0)e_issue_advamt, "
                       + "isnull(e_issue_spare,0)e_issue_spare,isnull(e_issue_fuel,0)e_issue_fuel,isnull(e_issue_comm,0)e_issue_comm,isnull(e_closure_balamt,0)e_closure_balamt,isnull(e_closure_incentive,0)e_closure_incentive,isnull(e_closure_deposit,0)e_closure_deposit, "
                       + "isnull(e_closure_dedamt,0)e_closure_dedamt,isnull(e_issue_totamt,0)e_issue_totamt,isnull(e_closure_totamt,0)e_closure_totamt,isnull(e_net_amt,0)e_net_amt,Tripsheet_startLoc,(select Locname from webx_location where loccode=Tripsheet_startLoc)as Tripsheet_startLocName,Tripsheet_EndLoc, (select Locname from webx_location where loccode=Tripsheet_EndLoc) as Tripsheet_EndLocName,Category,CustCode,Market_Own, From_city,To_City,Route,(Select custnm  from webx_CUSTHDR  where custcd=CustCode) as Custname, (Case when  Billed_YN= 'Y' then 'Billed'  else   'Not Billed'  end) Billed_Yn  "
                       + " from WEBX_FLEET_VEHICLE_ISSUE v "
                       + " where 1=1"
                       + " and V.VSlipNo='" + strVSlipNo + "'";
          
      System.Data.SqlClient.SqlCommand sqlcmd1 = new System.Data.SqlClient.SqlCommand(sql, conn);
      sqlcmd1.CommandType = System.Data.CommandType.Text;

     System.Data.SqlClient.SqlDataReader r1 = sqlcmd1.ExecuteReader();
     
        
        
        
        string VSlipDt="";
        string VehicleNo="";
        string Start_km="";
        string f_issue_fill="";
        string driver_name="";
        string License_no="";
        string valdity_dt="";
        string f_closure_closekm="";
        string f_closure_fill="";
        string Contractamt="";
        string c_Othercharg="";  
        string c_TDSrate="";
        string c_TDSamt="";
        string c_TDStype="";
        string c_Advamt_paid="";
        string c_issue_tot="";
        string c_dedamt="";
        string c_Balamt_paid="";
        string c_closure_tot="";
        string c_net_amt="";
        string e_issue_advamt="";
        string e_issue_spare="";
        string e_issue_fuel="";
        string e_issue_comm="";
        string e_closure_balamt="";
        string e_closure_incentive="";
        string e_closure_deposit="";
        string e_closure_dedamt="";
        string e_issue_totamt="";
        string e_closure_totamt="";
        string e_net_amt="";


        string Start_Loc = "";
        string End_Loc = "";
        string Category = "";
        string Custcode = "";
        string Market_Own = "";

        string From_City = "";
        string To_City = "";
        string Route = "";
        
        
        Double Tot_km = 0;
        string Tot_Kms = "";

        string Custname = "";
        string Billed_Yn = "";
        
     while (r1.Read())
     {

         //strVSlipNo = r1[""].ToString();
         VSlipDt = r1["VSlipDt"].ToString();
         VehicleNo = r1["VehicleNo"].ToString();
         Start_km = r1["Start_km"].ToString();
         f_issue_fill = r1["f_issue_fill"].ToString();
         driver_name = r1["driver_name"].ToString();
         License_no = r1["License_no"].ToString();
         valdity_dt = r1["valdity_dt"].ToString();
         f_closure_closekm = r1["f_closure_closekm"].ToString();
         f_closure_fill = r1["f_closure_fill"].ToString();
         Contractamt = r1["Contractamt"].ToString();
         c_Othercharg = r1["c_Othercharg"].ToString();
         c_TDSrate = r1["c_TDSrate"].ToString();
         c_TDSamt = r1["c_TDSamt"].ToString();
         c_TDSrate = r1["c_TDSrate"].ToString();
         c_TDSamt = r1["c_TDSamt"].ToString();
         c_TDStype = r1["c_TDStype"].ToString();
         c_Advamt_paid = r1["c_Advamt_paid"].ToString();
         c_issue_tot = r1["c_issue_tot"].ToString();
         c_dedamt = r1["c_dedamt"].ToString();
         c_Balamt_paid = r1["c_Balamt_paid"].ToString();
         c_closure_tot = r1["c_closure_tot"].ToString();
         c_net_amt = r1["c_net_amt"].ToString();
         e_issue_advamt = r1["e_issue_advamt"].ToString();
         e_issue_spare = r1["e_issue_spare"].ToString();
         e_issue_fuel = r1["e_issue_fuel"].ToString();
         e_issue_comm = r1["e_issue_comm"].ToString();
         e_closure_balamt = r1["e_closure_balamt"].ToString();
         e_closure_incentive = r1["e_closure_incentive"].ToString();
         e_closure_deposit = r1["e_closure_deposit"].ToString();
         e_closure_dedamt = r1["e_closure_dedamt"].ToString();
         e_issue_totamt = r1["e_issue_totamt"].ToString();
         e_closure_totamt = r1["e_closure_totamt"].ToString();
         e_net_amt = r1["e_net_amt"].ToString();



         Start_Loc = r1["Tripsheet_startLoc"].ToString() + " : " + r1["Tripsheet_startLocName"].ToString();

         End_Loc = r1["Tripsheet_EndLoc"].ToString() + " : " + r1["Tripsheet_EndLocName"].ToString(); 
         Category = r1["Category"].ToString();

         if (Category == "Internal Usage")
         {
             dgTHC.Visible = false;
             lblTHC.Visible = false;
             
         }
             
         Custcode = r1["Custcode"].ToString();
         Market_Own = r1["Market_Own"].ToString();

         From_City = r1["From_City"].ToString();
         To_City = r1["To_City"].ToString();
         Route = r1["Route"].ToString();

         Custname = r1["Custname"].ToString();


         Billed_Yn = r1["Billed_Yn"].ToString();
         

         
     }
     r1.Close();


     if (f_closure_closekm == "")
     {
         f_closure_closekm = "0";
     }
     if (Start_km == "")
     {
         Start_km = "0";
     }   
     Tot_km = (Convert.ToDouble(f_closure_closekm) - Convert.ToDouble(Start_km));


     Tot_Kms = Convert.ToString(Tot_km);
        

     %>
    
    
    

    
    
    
    
      <!-- <p align="right">
      <table   id="table1"  runat="server" visible="false"   cellspacing="1" cellpadding="3"  border="0">
            <tr style="background-color: white" align="right">
                <td colspan="4" align="right">
                
             
                  <%
                      string abc = "";
                      abc = Session["VSlipNo"].ToString();// Request.QueryString["VSlipId"];
                    %>
                              <a  id="Link11" runat="server" visible="false"  href="javascript:ViewPrint('<%=abc%>')"><font class="blackfnt">TripSheet Journey Details</font></a> 
                 </td>
                 </tr>
                 </table>
                 
                 </p>-->
    
    <br/>
    
    <table cellspacing="1" cellpadding="2" width="55%" align="center" class="boxbg" border="0" bgcolor="#8BA0E5">
     
     <tr style="background-color: white">
        <td colspan=4 align=left>
           <table cellspacing="1" cellpadding="2" width="100%" align="left" class="boxbg" border="1" bgcolor="#8BA0E5">
                     
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="TRIP SHEET"></asp:Label></td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Trip Sheet No.</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=strVSlipNo %></font>
                </td>
                <td align="left">
                <font class=bluefnt>Trip Sheet Date</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=VSlipDt%></font>
                </td>
            </tr>
                  <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Starting Location.</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=Start_Loc%></font>
                </td>
                <td align="left">
                <font class=bluefnt>End Location</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=End_Loc%></font>
                </td>
            </tr>
            
            
                  <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Category</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=Category%></font>
                </td>
                 <%
                if(Category=="External Usage")
                {%>
                <td align="left">
                <font class=bluefnt>Customer Code</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=Custcode%></font>
                </td>
                <%  }
                
                    if(Category=="Internal Usage")
                    {  %>
                  <td align="left">
                <font class=bluefnt>Market/Own</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=Market_Own%></font>
                </td>
                 <% } %>
                
                
            </tr>
            
            
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>From City</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=From_City%></font>
                </td>
                
                <td align="left">
                <font class=bluefnt>To City</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=To_City%></font>
                </td>
               
               
                 
                
                
            </tr>
            
              <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Route</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=Route%></font>
                </td>
                
                <td align="left">
                <font class=bluefnt> Tripsheet Billed/Not Billed</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=Billed_Yn%></font>
                </td>
               
                
                 
                
                
            </tr>
            
              <tr class="bgbluegrey">
                <td colspan=4 align=left><font class=blackfnt><b><asp:Label ID="lblTHC" Text="THC Details" CssClass="bluefnt" runat="server"></asp:Label> </b></font></td>
              </tr>
            
             <tr style="background-color: white">
                <td colspan=4 align=left>
                   
                   <table border="0" Width="100%">
                       <tr>
                          <td>
                          
                                            <asp:DataGrid ID="dgTHC" runat="server" AutoGenerateColumns="False"  OnItemDataBound="dgTHC_RowDataBound"
                                                    CellPadding="2" CssClass="dgRowStyle" HeaderStyle-CssClass="dgHeaderStyle" BackColor="White" BorderColor="#8BA0E5" BorderStyle="None"
                                                    BorderWidth="1px" Width="100%" Font-Size=XX-Small    ShowFooter="true">
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
                                                        
                                                        
                                                         <asp:BoundColumn DataField="FromCity" HeaderText="From">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                        <asp:BoundColumn DataField="ToCity" HeaderText="To">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                         <asp:BoundColumn DataField="THCNo" HeaderText="THC No.">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                         <asp:BoundColumn DataField="THCDt" HeaderText="THC Date">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                         <asp:BoundColumn DataField="FreightAmt" HeaderText="Freight Amount">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                        <asp:BoundColumn DataField="LabourAmt" HeaderText="Labour Charge">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                         <asp:BoundColumn DataField="OtherAmt" HeaderText="Other Charge">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                           <asp:BoundColumn DataField="TotalAmt" HeaderText="Total">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                        
                                                        </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>                          
                          
                          
                          </td>
                        </tr>
                   </table>                    
                 </td>
              </tr>  
            
            
            
            
            <tr visible="false" runat="server"  style="background-color: white">
                <td colspan=4 align=left>
                <table border="0" cellpadding="0" cellspacing="0" class="boxbg" width="100%">
                    <tr bgcolor="white">
                        <td style="height:19px" align=left>
                             <asp:datagrid id="DataGrid1"  runat="server" PageSize="1000"  AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left Font-Size=XX-Small >
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
                                
                                <asp:BoundColumn DataField="Request_Id" HeaderText="Req.ID" >
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="Request_By" HeaderText="Req. By">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="Request_dt" HeaderText="Req. Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="Orgn_city" HeaderText="Orign City">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <%--<asp:BoundColumn DataField="Destn_city" HeaderText="Destn. City">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>--%>
                                
                                 <asp:BoundColumn DataField="Destn_city" HeaderText="Destn. City">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="Start_date_time" HeaderText="Start date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="End_dt_tm" HeaderText="End date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <%--<asp:BoundColumn DataField="No_Passenger" HeaderText="Passengers">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>--%>
                                
                                
                                  <asp:BoundColumn DataField="Vehtype" HeaderText="Vehicle Type">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
	                            </Columns>
	                        </asp:datagrid>&nbsp;
		               </td>
                    </tr>
            </table>
         </td>
        </tr> 
        
         <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Vehicle No.</font>
                </td>
                <td align="left">
                     <font class=blackfnt><%=VehicleNo%></font>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>Driver</font>
                </td>
                <td align="left">
                 <font class=blackfnt><%=driver_name%></font>
                </td>
                
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Driver License No.</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                       <font class=blackfnt><%=License_no%></font>
                   </font>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>License Valid upto</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                     <font class=blackfnt><%=valdity_dt%></font>
                   </font>
                </td>
                
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Starting Km. Reading</font>
                </td>
                <td align="left">
                     <font class=blackfnt><%=Start_km%></font>
                </td>
                <td align="left" >
                  <font class=bluefnt>Closing Km. Reading</font>
                </td>
                <td align="left">
                    <font class=blackfnt><%=f_closure_closekm%></font> 
                </td>
                </tr>
                
                <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Fuel filled Ltrs.</font>
                </td>
                 <td align="left" >
                  <font class=blackfnt><%=f_issue_fill%></font> 
                </td>
                
                <td align="left" >
                  <font class=bluefnt>Fuel Filled enroute</font>
                </td>
                 <td align="left">
                    <font class=blackfnt><%=f_closure_fill%></font>  
                </td>
                </tr>
                
                
                  <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Total Kms.</font>
                </td>
                 <td align="left" >
                  <font class=blackfnt><%=Tot_Kms%></font> 
                </td>
                
                <td align="left" >
                  <font class=bluefnt></font>
                </td>
                 <td align="left">
                    <font class=blackfnt></font>  
                </td>
                </tr>
          </table>
        </td>        
      </tr>          
                
                
                
                
                
                
                
             
             <tr class="bgbluegrey">
                <td colspan=4 align=left><font class=blackfnt><b>Details of Advance Taken</b></font></td>
            </tr>
            
             <tr style="background-color: white">
                <td colspan=4 align=left>
                   
                   <table border="0" Width="100%">
                       <tr>
                          <td>
                          
                                            <asp:DataGrid ID="dgAdvanceDet" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="dgRowStyle" HeaderStyle-CssClass="dgHeaderStyle" BackColor="White" BorderColor="#8BA0E5" BorderStyle="None"
                                                    BorderWidth="1px" Width="100%" Font-Size=XX-Small>
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
                                                        
                                                        
                                                         <asp:BoundColumn DataField="AdvLoc" HeaderText="Place">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                        <asp:BoundColumn DataField="AdvDate" HeaderText="Advance Date">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                         <asp:BoundColumn DataField="AdvAmt" HeaderText="Amount">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                         <asp:BoundColumn DataField="THCno" HeaderText="THC No.">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                         <asp:BoundColumn DataField="BranchCode" HeaderText="Branch Code">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                        <asp:BoundColumn DataField="Signature" HeaderText="Signature">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                        </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>                          
                          
                          
                          </td>
                        </tr>
                   </table>                    
                 </td>
              </tr>  
              
              
              <tr class="bgbluegrey">
                <td colspan=4 align=left><font class=blackfnt><b>HSD/OIL Expenses</b></font></td>
            </tr>
             <tr style="background-color: white">
                <td colspan=4 align=left>
                   
                   <table border="0" Width="85%">
                       <tr>
                          <td> 
                       <asp:DataGrid ID="dgHSD_OIL_EXP" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="dgRowStyle" HeaderStyle-CssClass="dgHeaderStyle" BackColor="White" BorderColor="#8BA0E5" BorderStyle="None"
                                                    BorderWidth="1px" Width="85%" Font-Size=XX-Small>
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
                                                        
                                                        
                                                        <asp:BoundColumn DataField="Place" HeaderText="Place">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                         <asp:BoundColumn DataField="PetrolPName" HeaderText="Petrol Pump Name">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                        </asp:BoundColumn>
                                                         <asp:BoundColumn DataField="Brand" HeaderText="Brand">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                         <asp:BoundColumn DataField="FuelType" HeaderText="Fuel <br>Type">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                             <ItemStyle Wrap=false />
                                                        </asp:BoundColumn>
                                                         <asp:BoundColumn DataField="Last_Km_Read" HeaderText="Last Km Reading">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                        <asp:BoundColumn DataField="KM_Reading" HeaderText="KM Reading">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                        </asp:BoundColumn>
                                                        
                                                         <asp:BoundColumn DataField="BillNo" HeaderText="Bill No.">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        <asp:BoundColumn DataField="BillDt" HeaderText="Bill Date">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                        
                                                        
                                                         <asp:BoundColumn DataField="Diesel_Ltr" HeaderText="Diesel (Qtn. in litres)">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                        </asp:BoundColumn>
                                                        
                                                                     <asp:BoundColumn DataField="Diesel_Rate" HeaderText="Diesel Rate/litres">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                        <asp:BoundColumn DataField="Oil_Ltr" HeaderText="Oil (Qtn. in litres)">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                        </asp:BoundColumn>
                                                        
                                            
                                                       
                                                        
                                                        <asp:BoundColumn DataField="Oil_Rate" HeaderText="Oil Rate<br>/litres">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                             <ItemStyle Wrap=false />
                                                        </asp:BoundColumn>
                                                        
                                                        <asp:BoundColumn DataField="Amount" HeaderText="Amount">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                                <asp:BoundColumn DataField="Exe_Amt" HeaderText="Amount Approved By Fleet Executive">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                        </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="Card_Cash" HeaderText="By Card<br>/Cash">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                            <ItemStyle Wrap=false />
                                                        </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="Remark" HeaderText="Remarks">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                           </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>   
                          
                           
                          </td>
                        </tr>
                   </table>                    
                 </td>
              </tr>  
              
              
              
              
  <%--            <tr style="background-color: white">
                <td colspan=4>
                 <table cellspacing="1" cellpadding="3" style="width: 100%" align=center class="boxbg" border="0">
            
                    <tr style="background-color: white">
                        <td width="20%"><font class=blackfnt>Actual KMPL</font></td>
                        <td>
                            <asp:Label ID="lblActual_KMPL" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td></td>
                        <td></td>
                         <td rowspan=4 align=center valign=middle width="20%"><font class=blackfnt>Amount</font></td>
                        <td rowspan=4 align=center>
                        <asp:Label ID="lblAmt" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                       </tr> 
                       
                       <tr style="background-color: white">
                        <td ><font class=blackfnt>Actual Approved</font></td>
                        <td>
                            <asp:Label ID="lblKMPL_Approved" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td></td>
                        <td></td>
                        
                       </tr> 
                       
                         <tr style="background-color: white">
                        <td ><font class=blackfnt>Approved No. of litres</font></td>
                        <td>
                           <asp:Label ID="lblApprovedLtrs" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td width="20%"><font class=blackfnt>Approved @ of</font></td>
                        <td>
                           <asp:Label ID="lblApprovedRate" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                         
                       </tr> 
                       
                         <tr style="background-color: white">
                        <td ><font class=blackfnt>Approved Amount</font></td>
                        <td>
                           <asp:Label ID="lblApprovedAmt" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td></td>
                        <td></td>
                       </tr> 
                  </table>  
                </td>
            </tr>  --%>
            

<tr class="bgbluegrey" runat="server" visible="false" >
                <td colspan=4 align=left><font class=blackfnt><b>Repair Expenses</b></font></td>
            </tr>
             <tr style="background-color: white" runat="server" visible="false">
                <td colspan=4 align=left>
                   <table border="0" Width="100%">
                       <tr>
                          <td>
                                                <asp:DataGrid ID="dgRepairExp"  runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="dgRowStyle" HeaderStyle-CssClass="dgHeaderStyle" BackColor="White" BorderColor="#8BA0E5" BorderStyle="None"
                                                    BorderWidth="1px" Width="100%" Font-Size=XX-Small>
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
                                                        
                                                       
                                                          <asp:BoundColumn DataField="Supplier" HeaderText="Supplier">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                         <asp:BoundColumn DataField="SuppDesc" HeaderText="Description">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                         <asp:BoundColumn DataField="Qtn" HeaderText="Qtn.">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                         <asp:BoundColumn DataField="Rate_Unit" HeaderText="Rate/Unit">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        <asp:BoundColumn DataField="BillNo" HeaderText="Bill No.">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                         <asp:BoundColumn DataField="BillDt" HeaderText="Bill Date">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                         <asp:BoundColumn DataField="Amt" HeaderText="Amount">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                    </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid> 
                          
                          
                          </td>
                       </tr>
                   </table>    
                </td>
            </tr>   
            
             <tr runat="server" visible="false"  class="bgbluegrey">
                <td colspan=4 align=left><font class=blackfnt><b>Incidental Deduction details</b></font></td>
            </tr>   
            
            <tr runat="server" visible="false"  style="background-color: white">
                <td colspan=4 align=left>
                   <table border="0" Width="100%">
                       <tr>
                          <td>         

                                            <asp:DataGrid ID="dgIncidental" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="dgRowStyle" HeaderStyle-CssClass="dgHeaderStyle" BackColor="White" BorderColor="#8BA0E5" BorderStyle="None"
                                                    BorderWidth="1px" Width="100%"  Font-Size=XX-Small>
                                                    <Columns >
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
                                                        
                                                        
                                                        <asp:BoundColumn DataField="IncDt" HeaderText="Date">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                         <asp:BoundColumn DataField="TripFromDt" HeaderText="Trip Period From">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                         <asp:BoundColumn DataField="TripToDt" HeaderText="Trip Period To">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                         <asp:BoundColumn DataField="VoucherNo" HeaderText="Voucher No.">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                         <asp:BoundColumn DataField="VoucherDt" HeaderText="Voucher Date">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                         <asp:BoundColumn DataField="RecdDt" HeaderText="Recd. Date">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                         <asp:BoundColumn DataField="Amt" HeaderText="Amount">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        
                                                        </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>             

                         </td>
                       </tr>
                   </table>    
                </td>
            </tr>                  
                
                <tr runat="server" visible="false"    class="bgbluegrey">
                <td colspan="4" align="left">
                    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Spare Details"></asp:Label></td>
            </tr>
                <tr runat="server" visible="false"  style="background-color: white">
                <td colspan=4 align=left>
                   
                                    <table border="0" Width="100%">
                                                    <tr>
                                                        <td>
                                                       
                                                        <asp:DataGrid ID="DataGrid2" runat="server" AutoGenerateColumns="False"  
                                                    CellPadding="2" CssClass="dgRowStyle" HeaderStyle-CssClass="dgHeaderStyle" BackColor="White" BorderColor="#8BA0E5" BorderStyle="None"
                                                    BorderWidth="1px" Width="100%" ShowFooter=true Font-Size=XX-Small>
                                                    <Columns>
                                                        <asp:TemplateColumn HeaderText="Sr.No.">
                                                            <ItemTemplate>
                                                                <center>
                                                                    <%# Container.ItemIndex+1 %>
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                </center>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:BoundColumn DataField="PartId" HeaderText="Partname">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        <asp:BoundColumn DataField="Qty" HeaderText="Quantity">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                         <asp:BoundColumn DataField="rate" HeaderText="Rate">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        <asp:BoundColumn DataField="Amt" HeaderText="Amount">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                       
                                                        <asp:BoundColumn DataField="remark" HeaderText="Remark">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                    </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                   <%-- <FooterStyle BackColor="White" ForeColor="#000066" />--%>
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>
                                               </td>
                                             </tr>
                                            </table>    
                
              
                </td>
            </tr>
            
            
            
            
            
            
            
            
            
            
            
            

              <tr class="bgbluegrey">
                <td colspan="4" align="left">
                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="En-route Expenses"></asp:Label></td>
            </tr>
            
           
           
           
                 <tr style="background-color: white">
                <td colspan=4 align=left>
                
                 
                                    <table border="0" Width="100%">
                                                    <tr>
                                                        <td>
                                                      
                                                        <asp:DataGrid ID="dgEnroute" runat="server" AutoGenerateColumns="False" 
                                                    CellPadding="2" CssClass="dgRowStyle" HeaderStyle-CssClass="dgHeaderStyle" BackColor="White" BorderColor="#8BA0E5" BorderStyle="None"  
                                                    BorderWidth="1px" Width="100%" Font-Size=XX-Small>
                                                    <Columns>
                                                        <asp:TemplateColumn HeaderText="Sr.No.">
                                                            <ItemTemplate>
                                                                <center>
                                                                    <%# Container.ItemIndex+1 %>
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                </center>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        <asp:BoundColumn DataField="NExp" HeaderText="Nature Of Expense">
                                                         <ItemStyle HorizontalAlign=Left />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="Amount" HeaderText="Amount Spent"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="BillNo" HeaderText="Bill No (if Any)"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="Date" HeaderText="Date"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="Exe_Amt" HeaderText="Amount Approved <br>By Fleet Executive">
                                                        <ItemStyle Wrap=false />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="Remarks" HeaderText="Remark"></asp:BoundColumn>
                                                        
                                                        
                                                        
                                                    </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>
                                               </td>
                                             </tr>
                                            </table>    
                
             
                </td>
            </tr>           
            
            
            
<%--           New Change--%>
       <tr runat="server" visible="false"  class="bgbluegrey">
                <td colspan="4" align="left">
                    <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Claim  Details"></asp:Label></td>
            </tr>
            
           
           
           
                 <tr runat="server" visible="false" style="background-color: white">
                <td colspan=4 align=left>
                
                 
                                    <table border="0" Width="100%">
                                                    <tr>
                                                        <td>
                                                      
                                                        <asp:DataGrid ID="dgClaims" runat="server" AutoGenerateColumns="False" 
                                                    CellPadding="2"  BackColor="White" BorderColor="#8BA0E5" BorderStyle="None"  
                                                    BorderWidth="1px" Width="100%" CssClass="dgRowStyle" HeaderStyle-CssClass="dgHeaderStyle" Font-Size=XX-Small>
                                                    <Columns>
                                                        <asp:TemplateColumn HeaderText="Sr.No.">
                                                            <ItemTemplate>
                                                                <center>
                                                                    <%# Container.ItemIndex+1 %>
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                </center>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        <asp:BoundColumn DataField="Nature" HeaderText="Nature"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="No_Of_Packs" HeaderText="Damage/Shortage Qty. No. of Packs"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="Weight" HeaderText="Damage/Shortage Qty. Weight"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="Approx_Value" HeaderText="Damage/Shortage Qty. Approx.Value"></asp:BoundColumn>
                                                        
                            
                                                        
                                                        
                                                        
                                                    </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>
                                               </td>
                                             </tr>
                                            </table>    
                
             
                </td>
            </tr>           
            
           
            
            
            <tr class="bgbluegrey">
                <td colspan="4" align="left">
                    <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Trip Sheet Journey Details"></asp:Label></td>
            </tr>
            
            <tr style="background-color:White" align="center" >
                <td colspan="4" align="left" bgcolor="white">
                
                <asp:GridView ID="GridView1" runat="server"   
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            Font-Size=XX-Small>
                              <Columns>
                                <asp:BoundField DataField="thcno" HeaderText="VHC.No">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="thcdt1" HeaderText="THC Date">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                 <asp:BoundField DataField="sourcehb" HeaderText="Source">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                
                                   <asp:BoundField DataField="arrival" HeaderText="Arrival Date | Time">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                
                                   <asp:BoundField DataField="Dept" HeaderText="Dept.Date | Time">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                                              
                                <asp:BoundField DataField="route" HeaderText="Route Name">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                    <asp:BoundField DataField="ld_actuwt" HeaderText="Load(in Kg.)">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                
                                <asp:BoundField DataField="ld_tc" HeaderText="No.of Manifests"  />
                                <asp:BoundField DataField="TotKm" HeaderText="Total Km"   /> 
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        
                </td>
            </tr>    
            
            
             <tr class="bgbluegrey">
                <td colspan="4" align="left">
                    <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Advance And Expense Summary"></asp:Label></td>
            </tr>
            
            <tr  style="background-color:White" align="left" > 
            <td align="left"  bgcolor="white"  colspan="4">
            <table  width="100%" border="0" bgcolor="white" cellspacing=0 cellpadding=0>
            <tr style="background-color:White" align="left">
            <td align="left" valign="top"  style="background-color:White"  >
            
               <asp:GridView ID="dgAdvSummary" runat="server" AutoGenerateColumns="False"  ShowFooter="true" OnRowDataBound="dgAdvSummary_RowDataBound"
                                                    CellPadding="2" CssClass="dgRowStyle" HeaderStyle-CssClass="dgHeaderStyle" BorderColor="#8BA0E5" BorderStyle="None"  
                                                    BorderWidth="1px" Width="100%" Font-Size=XX-Small>
                                                    <Columns>
                                                         
                                                        <asp:BoundField DataField="ADVLoc" HeaderText="Location"></asp:BoundField>
                                                        <asp:BoundField DataField="ADVAmt" HeaderText="Advance Amount"></asp:BoundField>
                                                                                                                                                                                                   
                                                                                                               
                                                    </Columns>
                                             
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"  />
                                                </asp:GridView>
               
            
            </td>
            <td align="left" >
             <asp:GridView ID="dgExpense" runat="server" AutoGenerateColumns="False" ShowFooter="true"  OnRowDataBound="dgExpense_RowDataBound"
                                                    CellPadding="2" BackColor="White" BorderColor="#8BA0E5" BorderStyle="None"  
                                                    BorderWidth="1px" Width="100%" CssClass="dgRowStyle" HeaderStyle-CssClass="dgHeaderStyle" Font-Size=XX-Small>
                                                    <Columns>
                                                                                          
                                                       <asp:BoundField DataField="Expenses" HeaderText="Expense Type"></asp:BoundField>
                                                        <asp:BoundField DataField="Amount" HeaderText="Amount"></asp:BoundField>
                                                        <asp:BoundField DataField="ApprovedAmount" HeaderText="Amount Approved"></asp:BoundField>
                                                                                                                                                                                                                                                        
                                                    </Columns>
                                                    
                                                    
                                                
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:GridView>
            
             
            
            
            </td>
            </tr>
            </table>
            </td>
                      
            </tr>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
             <tr class="bgbluegrey">
                <td colspan=4 align=left><font class=blackfnt><b>Verifying Authorities</b></font></td>
            </tr>
            
            
             <tr style="background-color: white">
                <td colspan=4 align=left>
                 <table cellspacing="1" cellpadding="3" width="100%" align=left class="boxbg" border="1" >
            
                    <tr style="background-color: white">
                        <td align=center><asp:Label ID="lblPreparedBy" runat="server" CssClass="blackfnt"></asp:Label></td>
                        <td align=center><asp:Label ID="lblCheckedBy" runat="server" CssClass="blackfnt"></asp:Label></td>
                        <td align=center><asp:Label ID="lblApprovedBy" runat="server" CssClass="blackfnt"></asp:Label></td>
                        <td align=center><asp:Label ID="lblAuditedBy" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr> 
                    
                    <tr style="background-color: white">
                        <td align=center><font class=blackfnt>Prepared By</font></td>
                        <td align=center><font class=blackfnt>Checked By</font></td>
                        <td align=center><font class=blackfnt>Apporved By</font></td>
                        <td align=center rowspan=2><font class=blackfnt>Audited By</font></td>
                    </tr> 
                    <tr style="background-color: white">
                        <td align=center><font class=blackfnt>Fleet Accounts</font></td>
                        <td align=center><font class=blackfnt>Fleet Manager</font></td>
                        <td align=center><font class=blackfnt><b>HOD</b></font></td>
                    </tr> 
                    
                  </table>
                </td>
               </tr>   
            
                   
            
           
                      
               
     </table>
   <%--  </p>--%>
    
    </div>
    </form>
</body>
</html>
