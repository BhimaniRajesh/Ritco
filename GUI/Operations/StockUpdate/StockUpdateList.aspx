<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" ValidateRequest = "false"
    CodeFile="StockUpdateList.aspx.cs"  Inherits="GUI_Operations_UpdateDocketArrivalStatus_StockUpdateList" 
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_DelyReasons" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="usp_DeliveryReasons" SelectCommandType="StoredProcedure">
        <%--        <SelectParameters>
            <asp:Parameter DefaultValue='L' Name="ReasonType" Type="char" Size="1" />
        </SelectParameters>--%>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_ArrivalConditions" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="usp_ArrivalConditions" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Godowns" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="usp_Godowns" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="brcd" DefaultValue="" QueryStringField="BRCD" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="./Js/StockUpdate.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">   
    function checkAll()
     {
    /* // alert("Hii")
      var chk=null;
        var i=0;
        debugger
      var chkall=document.getElementById("ctl00_MyCPH1_CHKSTUP_All");
      var grid=document.getElementById("ctl00_MyCPH1_hStockList");
     // alert(grid);
      var rows=grid.value;  
     // alert(rows);
      
        
   
       for(var i=0;i<=rows-1;i++)
       {
            
            if(i>=10 )
            {
                 chk=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + i +"_CHKSTUP");
                 arpkg=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + i +"_txtArrvPkgs");
                 arwt=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + i +"_txtArrvWt");
                 arcn=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + i +"_cboArrivalConditions");
                 argd=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + i +"_cboGodowns");
            }
            else 
            {
                chk=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl0" + i +"_CHKSTUP");
                 arpkg=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl0" + i +"_txtArrvPkgs");
                 arwt=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl0" + i +"_txtArrvWt");
                 arcn=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl0" + i +"_cboArrivalConditions");
                 argd=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl0" + i +"_cboGodowns");
            }
                                      
               if(chkall.checked==true)
                {               
                       if(chk.disabled==false)
                        {     
                           chk.checked=true;
                          arpkg.disabled=false;
                          arcn.disabled=false;
                          argd.disabled=false;
                      
                        }
                }
                else
                {
                    
                    chk.checked=false;
                    arpkg.disabled=true;
                    arcn.disabled=true;
                      argd.disabled=true;
                      arwt.disabled=true;
                 }
                                   
           
        } 
        return true;*/
     }
     
     
    function CHK_WT(arwt)
    {
        rowid=arwt.getAttribute('ID').substring(30,32)
        chgwt=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + rowid +"_hdwt");
             chgpkg=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + rowid +"_hdpkgsno");
                 Arrpkg=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + rowid +"_txtArrvPkgs");
       if(chgwt.value<=arwt.value)
         {
            alert("Weight Should Be  Less Than "+chgwt.value )                    
            //arwt.value=chgwt.value;            
            arwt.value=Math.round((chgwt.value/chgpkg.value)*Arrpkg.value)
            arwt.focus();  
         }  
         
    }
     
     
     function ENABLED_WT(chkpkg)
    {
    // alert(chkpkg.value)
      rowid=chkpkg.getAttribute('ID').substring(30,32)
        chgpkg=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + rowid +"_hdpkgsno");
         chgwt=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + rowid +"_hdwt");
     //alert(chgpkg.value)
     
      arwt=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + rowid +"_txtArrvWt");
         if(chgpkg.value<chkpkg.value)
         {
            alert("Arrived Pkgsno Should Be  Less Than "+chgpkg.value )
            arwt.disabled=true;                  
                                chkpkg.value=chgpkg.value;
                                chkpkg.focus();
         }
         else 
         {
            arwt.value=Math.round((chgwt.value/chgpkg.value)*chkpkg.value)
            arwt.disabled=false;
         }
         
         if(chgpkg.value==chkpkg.value)
         {
              arwt.disabled=true;
              arwt.value=chgwt.value;
         }
         
        
     }
     
     
      function ENABLED_MSALLFIELDS(chkval)
    {
       //alert(chkval.getAttribute('ID'))
        rowid=chkval.getAttribute('ID').substring(0,31)
         msardkt=document.getElementById("" + rowid +"txtmrdkt");
              
                
        if(chkval.checked==true)
                {
                    msardkt.disabled=false;
                  //  alert(msardkt.getAttribute('ID'))     
                    msardkt.focus();
                }
                else
                {
                   msardkt.disabled=true;
                 }
            
            }
     
     
     
    function ENABLED_ALLFIELDS(chkval)
    {
      //  alert(chkval.getAttribute('ID'))
        rowid=chkval.getAttribute('ID').substring(30,32)
        
        arpkg=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + rowid +"_txtArrvPkgs");
                 arwt=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + rowid +"_txtArrvWt");
                 arcn=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + rowid +"_cboArrivalConditions");
                 argd=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + rowid +"_cboGodowns");
         
        if(chkval.checked==true)
                {
                    arpkg.disabled=false;
                     arcn.disabled=false;
                      argd.disabled=false;
                }
                else
                {
                   arpkg.disabled=true;
                    arcn.disabled=true;
                      argd.disabled=true;
                       arwt.disabled=true;
                 }
    }
    
    
    function ShowMS() 
       {
             document.getElementById('ctl00_MyCPH1_Tr4').style.display = "block";   
       }
       
         function HideMS() 
       {
        document.getElementById('ctl00_MyCPH1_Tr4').style.display = "none";   
        
       }
    
   function OnDKTBlur(id)
   {
            // document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
            var txtDKT=id;
           // alert(txtDKT.getAttribute('ID'))
            rowid=txtDKT.getAttribute('ID').substring(0,31)
            msarpkg=document.getElementById("" + rowid +"txtmrpkgs");
            msarwt=document.getElementById("" + rowid +"txtmrwt");
            
             hrmsarpkg=document.getElementById("" + rowid +"hrtxtmrpkgs");
            hrmsarwt=document.getElementById("" + rowid +"hrtxtmrwt");
            
            var DOCKET=txtDKT.value;
            
              if(DOCKET==" ")
            { msarpkg.innerText=""
                  msarwt.innerText=""
                  }
            if(DOCKET=="")
            {
                  msarpkg.innerText=""
                  msarwt.innerText=""
                return false;
                }
         
        
            var findobj=false;
            findobj=GetXMLHttpObject();
            
             if(findobj)
            {
            
                var strpg="CheckDKT.aspx?DOCKET=" + DOCKET;
                 findobj.open("GET",strpg,true);
                 findobj.onreadystatechange=function()
                 {
                // alert(findobj.responseText)
                     if(findobj.readyState==4 && findobj.status==200)
                        {
                            var res=findobj.responseText.split("|");
                             //alert(res[0])
                         
                            if(res[1]!="" )
                            {
                               if( res[1]!="Y")
                               {
                                        if(res[1]=="N")
                                        {
                                        alert("Document Number is Not Exists... Please Enter Valid Document Number");                               
                                        txtDKT.value="";
                                        txtDKT.focus();
                                        }
                                        
                                        else 
                                        {
                                          alert(res[1])
                                        }                               
                                
                                return false;
                                }
                                else
                                {
                                    msarpkg.innerText=res[2]
                                    msarwt.innerText=res[3]
                                    hrmsarpkg.innerText=res[2]
                                    hrmsarwt.innerText=res[3]
                                    
                                    //return true;
                                }
                                
                            }                         
                            
                        }
                 }
            findobj.send(null);
            }
            return false;
   }
    
    function checkAll_ArrvCD()
     {
     // alert("Hii")
      var chk=null;
        var i=0;
      var chkall=document.getElementById("ctl00_MyCPH1_cboArrivalConditions_All");  
        do
        {           
            if(i>=10 )
                 chk=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + i +"_cboArrivalConditions");
            else 
                chk=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl0" + i +"_cboArrivalConditions");
                 
             if(chk)
            {  
                chk.value=chkall.value;
             }
                          
            i++;
        }while(chk);        
        return true;
     }
     
     
     function checkAll_GD()
     {
     // alert("Hii")
      var chk=null;
        var i=0;
      var chkall=document.getElementById("ctl00_MyCPH1_cboGodowns_All");  
        do
        {           
            if(i>=10 )
                 chk=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl" + i +"_cboGodowns");
            else 
                chk=document.getElementById("ctl00_MyCPH1_rptDocketList_ctl0" + i +"_cboGodowns");
                 
             if(chk)
            {  
                chk.value=chkall.value;
             }
                          
            i++;
        }while(chk);        
        return true;
     }
    </script>

    <asp:UpdatePanel ID="upStockUpdate"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 900px">
                <tr style="background-color: white">
                    <td align="left" style="width: 50%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Stock List:</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                        <asp:HiddenField ID="hTHCNo" runat="server" EnableViewState="true" />
                        <asp:HiddenField ID="hBrCd" runat="server" EnableViewState="true" />
                        <asp:HiddenField ID="hStockList" runat="server" EnableViewState="true" />
                         <asp:HiddenField ID="MSRDKTList" runat="server" EnableViewState="true" />
                        <asp:HiddenField ID="hXMLData" runat="server" EnableViewState="true" />
                        <asp:HiddenField ID="hXMLData_MSRDKT" runat="server" EnableViewState="true" />
                        <asp:HiddenField ID="hXMLData_NonArr" runat="server" EnableViewState="true" />
                        <asp:HiddenField runat="server" ID="hSysDate" />
                    </td>
                    <td align="left">
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
                        &nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
            <table cellspacing="1" cellpadding="3" style="width: 400px" class="boxbg">
                <tr class="bgbluegrey">
                    <td align="left" colspan="2">
                        <font class="blackfnt"><b>THC Information:</b></font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left" style="width: 50%">
                        <font class="blackfnt">THC #:</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                            <%= THCNo%>
                        </font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left" style="width: 50%">
                        <font class="blackfnt">THC Date:</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                            <%= THCDate %>
                        </font>
                        <input type="hidden" name="hTHCDate" value="<%= THCDate %>" />
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left" style="width: 50%">
                        <font class="blackfnt">THC Arrival Date @
                            <%= Session["brcd"].ToString()%>
                        </font>
                        <asp:HiddenField ID="hTHCArrvDate" runat="server" />
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                            <%= THCArrivalDate %>
                        </font>
                        <input type="hidden" name="hTHCDate" value="<%= THCArrivalDate %>" />
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left" style="width: 50%">
                        <font class="blackfnt">Vehicle #:</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                            <%=vehicleno %>
                        </font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left" style="width: 50%">
                        <font class="blackfnt">Total Manifest Count:</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                            <%=MFKount %>
                        </font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left" style="width: 50%">
                        <font class="blackfnt">Total Docket Count:</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                            <%=DocketKount %>
                        </font>
                    </td>
                </tr>
            </table>
            <br />
            <table cellspacing="1" cellpadding="3" style="width: 400px" class="boxbg">
                <tr class="bgbluegrey">
                    <td align="left">
                        <font class="blackfnt"><b>Stock Update Date:</b></font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:TextBox ID="txtStockUpdateDate" runat="server" CssClass="input" MaxLength="10"
                            Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtStockUpdateDate,'b','dd/MM/yyyy'); return false;"
                            id="b">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                    </td>
                </tr>
            </table>
            <br />
            <table cellspacing="1" cellpadding="3" style="width: 1200px" class="boxbg">
                <tr style="background-color: White">
                    <td colspan="13" align="left">
                        <font class="blackfnt"><b>Stock Update List</b></font>
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="left" style="width: 5%">
                        <font class="blackfnt"><b>Sr.#</b></font>
                    </td>
                    <td align="left" style="width: 5%">
                        <%--<asp:CheckBox ID="CHKSTUP_All" runat="server" Onclick="Javascript:return checkAll();" />--%>
                        <asp:CheckBox ID="CHKSTUP_All" runat="server"  Enabled="false" Checked="true" />
                    </td>
                    <td align="left" style="width: 5%">
                        <font class="blackfnt"><b>MF #</b></font>
                    </td>
                    <td align="left" style="width: 10%">
                        <font class="blackfnt"><b>Docket #<br />
                            Bkg-Dest</b></font>
                    </td>
                    <td align="left" style="width: 7%">
                        <font class="blackfnt"><b>Bkg. Date</b></font>
                    </td>
                    <td align="left" style="width: 7%">
                        <font class="blackfnt"><b>Commited<br />
                            Dely. Date</b></font>
                    </td>
                    <td align="center" style="width: 5%">
                        <font class="blackfnt"><b>Pkgs.</font>
                    </td>
                    <td align="center" style="width: 5%">
                        <font class="blackfnt"><b>Wt.</font>
                    </td>
                    <td align="left" style="width: 15%">
                        <font class="blackfnt"><b>Biz. Type<br />Service Type</font>
                    </td>
                    <td align="left" style="width: 8%">
                        <font class="blackfnt"><b>Arrived Pkgs.</b></font>
                    </td>
                    <td align="left" style="width: 8%">
                        <font class="blackfnt"><b>Arrived Wt.</b></font>
                    </td>
                    <td align="left" style="width: 10%">
                        <font class="blackfnt"><b>Arrival Condition</b></font>
                        <asp:DropDownList ID="cboArrivalConditions_All" runat="server" OnChange="Javascript:return checkAll_ArrvCD();"
                            CssClass="input" DataSourceID="MySQLDataSource_ArrivalConditions" DataTextField="Code"
                            DataValueField="CodeID">
                        </asp:DropDownList>
                    </td>
                    <td align="left" style="width: 10%">
                        <font class="blackfnt"><b>Warehouse ID</b></font>
                        <asp:DropDownList ID="cboGodowns_All" runat="server" CssClass="input" DataSourceID="MySQLDataSource_Godowns"
                            OnChange="Javascript:return checkAll_GD();" DataTextField="godown_name" DataValueField="godown_srno"
                            OnDataBound="ShowFirstGodown">
                        </asp:DropDownList>
                    </td>
                    <%--                    <td align="left">
                        <font class="blackfnt"><b>Octroi (Rs.)</b></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><b>Processing<br />Charge (Rs.)</b></font>
                    </td>
--%>
                </tr>
                <asp:Repeater ID="rptDocketList" runat="server" Visible="true" OnItemDataBound="rptDocketList_ItemDataBound">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <td align="left">
                                <font class="blackfnt">
                                    <%# Container.ItemIndex + 1%>
                                </font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                   <%-- <asp:CheckBox ID="CHKSTUP"  runat="server" Onclick="Javascript:return ENABLED_ALLFIELDS(this);" />--%>
                                   <asp:CheckBox ID="CHKSTUP"  runat="server"   Checked="true"  Enabled="false"/>
                                </font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "TCNO").ToString().Trim()%>
                                </font>
                            </td>
                            <td align="left">
                                <font class="bluefnt">
                                    <%# DataBinder.Eval(Container.DataItem, "DOCKNO").ToString().Trim() + DataBinder.Eval(Container.DataItem, "DOCKSF").ToString().Trim() %>
                                </font>
                                <br>
                                <font class='blackfnt'>
                                    <%#DataBinder.Eval(Container.DataItem, "ORGNCD").ToString().Trim() + "-" + DataBinder.Eval(Container.DataItem, "DEST_CD").ToString().Trim()%>
                                </font>
                                <asp:HiddenField ID="hMF" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "TCNO").ToString().Trim()%>' />
                                <asp:HiddenField ID="hDocket" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "DOCKNO").ToString().Trim()%>' />
                                <asp:HiddenField ID="hDocketSF" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "DOCKSF").ToString().Trim()%>' />
                                <asp:HiddenField ID="hPkgs" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "PKGSNO").ToString().Trim()%>' />
                                <asp:HiddenField ID="hWt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "ACTUWT").ToString().Trim()%>' />
                                <asp:HiddenField ID="hBkgPkgs" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "BKG_PKGSNO").ToString().Trim()%>' />
                                <asp:HiddenField ID="hBkgWt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "BKG_ACTUWT").ToString().Trim()%>' />
                                <asp:HiddenField ID="hDelyOnStockUpdate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "DelyOnStockUpdateChar").ToString().Trim()%>' />
                                <asp:HiddenField ID="hCDelyDt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "CDELYDT").ToString().Trim()%>' />
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "DOCKDT").ToString().Trim()%>
                                </font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "CDELYDT").ToString().Trim()%>
                                </font>
                            </td>
                            <td align="center">
                                <font class="blackfnt">
                                    <%# "<font color='red'>" + DataBinder.Eval(Container.DataItem, "PKGSNO").ToString().Trim() + "</font>"%>
                                </font>
                            </td>
                            <td align="center">
                                <font class="blackfnt">
                                    <%# "<font color='red'>" + DataBinder.Eval(Container.DataItem, "ACTUWT").ToString().Trim() + "</font>"%>
                                </font>
                            </td>
                            <td align="left">
                                <%# "<font class='bluefnt'>" + DataBinder.Eval(Container.DataItem, "BizType").ToString().Trim() + "</font>"%>
                                <br>
                                <font class='blackfnt'>
                                    <%#DataBinder.Eval(Container.DataItem, "Service_Class").ToString().Trim()%>
                                </font>
                            </td>
                            <td align="left">
                                    <asp:HiddenField ID="hdpkgsno" Value='<%#DataBinder.Eval(Container.DataItem, "PKGSNO").ToString().Trim()%>'
                                        runat="server" />
                                <asp:TextBox ID="txtArrvPkgs" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "PKGSNO").ToString().Trim()%>'
                                    MaxLength="5" Width="50" OnChange="Javascript:return ENABLED_WT(this);" Enabled="false"
                                    CssClass="input"></asp:TextBox>
                            </td>
                            <td align="left">
                                 <asp:HiddenField ID="hdwt" Value='<%#DataBinder.Eval(Container.DataItem, "ACTUWT").ToString().Trim()%>'
                                    runat="server" />
                                <asp:TextBox ID="txtArrvWt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ACTUWT").ToString().Trim()%>'
                                    MaxLength="9" Width="50"  OnChange="Javascript:return CHK_WT(this);" Enabled="false" CssClass="input"></asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="cboArrivalConditions" runat="server" CssClass="input" DataSourceID="MySQLDataSource_ArrivalConditions"
                                    DataTextField="Code"  DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="cboGodowns" runat="server" CssClass="input" DataSourceID="MySQLDataSource_Godowns"
                                    DataTextField="godown_name"  DataValueField="godown_srno" OnDataBound="ShowFirstGodown">
                                </asp:DropDownList>
                            </td>
                            <%--      Enabled="false"   Enabled="false"                   <td align="left">
                                <asp:TextBox ID="txtOctroi" runat="server" Text="0" MaxLength="5" Width="50" CssClass="input"></asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtProcChg" runat="server" Text="0" MaxLength="5" Width="50" CssClass="input"></asp:TextBox>
                            </td>--%>
                        </tr>
                        <tr style="background-color: White" id="trDely" runat="server" visible='<%# DataBinder.Eval(Container.DataItem,"DelyOnStockUpdate") %>'>
                            <td colspan="13">
                                <table cellspacing="1" cellpadding="3" border="0" class="boxbg" width="100%">
                                    <tr style="background-color: #EFEFEF">
                                        <td align="left">
                                            <font class="blackfnt">Delivery Date &amp; Time:</font>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtDelyDt" runat="server" MaxLength="10" Width="70" CssClass="input"
                                                Text='<%# DateTime.Now.ToString("dd/MM/yyyy") %>'></asp:TextBox>
                                            <a href="#" onclick="var a=<%#Container.ItemIndex %>;if(a>9){a = 'ctl00_MyCPH1_rptDocketList_ctl' + a +'_txtDelyDt'} else {a = 'ctl00_MyCPH1_rptDocketList_ctl' + '0'+a+'_txtDelyDt' };var lnk=a+'lnk'/*; alert(lnk)*/;this.id=lnk;cal.select(eval('document.aspnetForm.'+a),this.id,'dd/MM/yyyy'); return false;">
                                                <img src="./../../images/calendar.jpg" border="0" />
                                            </a>&nbsp;
                                            <asp:TextBox ID="txtHHMM" runat="server" MaxLength="5" Width="30" CssClass="input"
                                                Text='<%# DateTime.Now.ToString("HH:mm") %>'></asp:TextBox>
                                            <font class="blackfnt">dd/mm/yyyy HH:MM</font>
                                        </td>
                                        <td align="left">
                                            <font class="blackfnt">Reason:</font>
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="cboReason" runat="server" CssClass="input" DataSourceID="MySQLDataSource_DelyReasons"
                                                DataTextField="Code" DataValueField="CodeID">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="left">
                                            <font class="blackfnt">Person:</font>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtPerson" runat="server" CssClass="input" Width="100" MaxLength="50"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="trCODDOD" style="background-color: White" runat="server" visible='<%# DataBinder.Eval(Container.DataItem, "IsCODDOD")%>'>
                            <td colspan="13">
                                <table cellspacing="1" cellpadding="3" border="0" class="boxbg" width="100%">
                                    <tr style="background-color: #FFFFDF">
                                        <td align="left" style="width: 15%">
                                            <font class="blackfnt">COD/DOD Amount:</font>
                                        </td>
                                        <td align="left" style="width: 20%">
                                            <font class="blackfnt">
                                                <%# DataBinder.Eval(Container.DataItem, "CODDODAmount")%>
                                            </font>
                                            <asp:HiddenField ID="hCODDODAmount" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "CODDODAmount")%>' />
                                        </td>
                                        <td align="left" style="width: 15%">
                                            <font class="blackfnt">COD/DOD Collected:</font>
                                        </td>
                                        <td align="left" style="width: 20%">
                                            <asp:TextBox ID="txtCODDOCCollected" runat="server" Width="30" CssClass="input"></asp:TextBox>
                                        </td>
                                        <td align="left" style="width: 10%">
                                            <font class="blackfnt">COD/DOD #:</font>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtCODDODNo" runat="server" Width="100" CssClass="input" MaxLength="25"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <tr id="Tr3" style="background-color: White" runat="server">
                    <td colspan="13" style="height: 30px" align="left">
                    </td>
                </tr>
                <tr id="Tr1" style="background-color: White" runat="server">
                    <td colspan="13" align="left">
                        <font class="bluefnt"><b>Declare Misroute Dockets #:</b><a href="Javascript:ShowMS();">
                                    <font class="bluefnt"><u><b>Show</b></u></font> </a><font class="blackfnt">/</font>
                                <a href="Javascript:HideMS();"><font class="bluefnt"><u><b>Hide</b></u></font>
                                </a></font>
                    </td>
                </tr>
                <tr id="Tr4" style="background-color: White; display:none;" runat="server">
                    <td colspan="13" align="center">
                    <br />
                        <asp:UpdatePanel ID="UpdatePanel4" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="350">
                                    <tr style="background-color: White">
                                        <td style="text-align: left" class="blackfnt">
                                            &nbsp;Enter No. of Rows
                                        </td>
                                        <td style="text-align: left" class="blackfnt">
                                            &nbsp;<asp:TextBox ID="txtRows" Text="3" runat="server" BorderStyle="Groove" onkeypress="javascript:validInt(event);"
                                                CssClass="input" Width="50px"></asp:TextBox>
                                            &nbsp;<asp:Button ID="btnAdd" UseSubmitBehavior="false" runat="server" Text="Add Rows"
                                                OnClick="btnAdd_Click" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table border="0" cellpadding="0" cellspacing="0" width="500">
                                    <tr style="background-color: White">
                                        <td style="text-align: left" class="blackfnt">
                                            <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                                CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                                                PagerStyle-HorizontalAlign="left" Width="100%" ShowFooter="True">
                                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                                <FooterStyle CssClass="boxbg" />
                                                <Columns>
                                                   <%-- <asp:TemplateField HeaderText="Sr. No.">
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                                    
                                                     <%--Onclick="Javascript:return ENABLED_MSALLFIELDS(this);"--%>
                                                    <asp:TemplateField ItemStyle-HorizontalAlign="left">
                                                        <ItemTemplate >
                                                            <asp:CheckBox ID="CHKMR" runat="server"  Onclick="Javascript:return ENABLED_MSALLFIELDS(this);"/>
                                                        </ItemTemplate>
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Docket. No.">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtmrdkt"  Enabled="false" CssClass="blackfnt" runat="server"  Onblur="Javascript:return OnDKTBlur(this);"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Pkgs">
                                                        <ItemTemplate>
                                                        <asp:HiddenField ID="hrtxtmrpkgs"  runat="server"/>
                                                            <asp:Label ID="txtmrpkgs" CssClass="blackfnt" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Actual Weight">
                                                        <ItemTemplate>
                                                         <asp:HiddenField ID="hrtxtmrWt"  runat="server"/>
                                                            <asp:Label ID="txtmrWt" CssClass="blackfnt" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Left" />
                                            </asp:GridView>
                                            <br />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr id="Tr2" style="background-color: White" runat="server">
                    <td colspan="13" align="left">
                        <asp:Button Text="Do Stock Update >>" ID="btnStockUpdate" runat="server" OnClientClick="return ValidateDocketData()"
                            OnClick="StockUpdate" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 100;">
    </div>
</asp:Content>
