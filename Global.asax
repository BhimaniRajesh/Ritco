<%@ Application Language="C#" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Timers" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="WebX.Controllers" %>
<%@ Import Namespace="System.Data" %>

<script RunAt="server">


    public readonly System.Timers.Timer DRS_AUTO_MAIL = new System.Timers.Timer();

    System.Timers.Timer autoGetEwayBillDetailsGSTINWise = new System.Timers.Timer();

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        // Set the Interval to 5 min (300000 milliseconds).
        // Set the Interval to 1 min (60000 milliseconds).


        //JobScheduler.Start();
        DRS_AUTO_MAIL.Interval = 60000;
        DRS_AUTO_MAIL.AutoReset = true;
        DRS_AUTO_MAIL.Elapsed += new ElapsedEventHandler(myTimer_ElapsedDRS_AUTO_MAIL);
        DRS_AUTO_MAIL.Enabled = true;
        DRS_AUTO_MAIL.Start();


        //JobScheduler.Start();
    }


    public void myTimer_ElapsedDRS_AUTO_MAIL(object source, System.Timers.ElapsedEventArgs e)
    {
        try
        {
            ChequeBounce_Controller obj = new ChequeBounce_Controller();
            //obj.SendEmailForCheque();
        }
        catch (Exception ex)
        {
            WebX.Common.ExceptionUtils.LogException(ex, "gloabal.asax->myTimer_ChequeBounceAutomail");
        }

    }

    //void Application_BeginRequest(object sender, EventArgs e)
    //{
    //    if (Request.Url.ToString().ToUpper().Contains("WS_WEBX_GPS.ASMX"))
    //    {
    //        try
    //        {
    //            // Creates a unique id to match Rquests with Responses
    //            string id = string.Format("Id: {0} Uri: {1}", Guid.NewGuid(), Request.Url);
    //            //string id = string.Format("Id: {0} Uri: {1}{4}CallerIp: {2} Agent: {3}", Guid.NewGuid(), Request.Url, Request.UserHostAddress, Request.UserAgent, Environment.NewLine);

    //            FilterSaveLog input = new FilterSaveLog(HttpContext.Current, Request.Filter, FileName, id);
    //            Request.Filter = input;
    //            input.SetFilter(false);

    //            FilterSaveLog output = new FilterSaveLog(HttpContext.Current, Response.Filter, FileName, id);
    //            output.SetFilter(true);
    //            Response.Filter = output;
    //        }
    //        catch (Exception ex)
    //        {
    //        }
    //    }
    //}

    /// <summary>
    /// The event occurs just after Initialization of Session, and before Page_Init event
    /// </summary>
    //protected void Application_PreRequestHandlerExecute(Object sender, EventArgs e)
    //{
    //    // here it checks if session is required, as
    //    // .aspx requires session, and session should be available there
    //    // .jpg, or .css does require session so session will be null
    //    // as .jpg, or .css are also HTTP request in either case if you implemented URL Rewriter, or custom IHttp Module
    //    if (Context.Handler is IRequiresSessionState || Context.Handler is IReadOnlySessionState)
    //    {
    //        //If service then return
    //        if (!Context.Request.Url.AbsoluteUri.ToUpper().Contains("/SERVICES/"))
    //        {
    //            // here is your actual code
    //            // check if session is new one
    //            // or any of your logic
    //            if (Session.IsNewSession || Session.Count < 1)
    //            {
    //                // checking if request is not for default.aspx page, as it should not be redirected
    //                if (!Context.Request.Url.AbsoluteUri.ToLower().Contains("/login.aspx")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/GUI/WARNING.ASPX")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/GUI/ADMIN/FORGOTPASSWORD/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/BLOCKIP.ASPX")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CLIENTS/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CUSTOMERLOGIN/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CONTROLTOWER/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CONTROLTOWERV2/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CONTROLTOWERV3/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CONTROLTOWERV4/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/TRACKING_NEW/WEBSITE/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/TRACKING_NEW/WEBSITE/TRACKCONSIGNMENT.ASPX")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/TRACKING_NEW/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/ADMIN/FORGOTPASSWORD/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/RESTSERVICE/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/SERVICE/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/SERVICES/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/SERVICES/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/WS_WEBX_GPS.ASMX")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/GPS_TRACK/")
    //                    && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/FDSM/")
    //                  )
    //                {
    //                    Context.Response.Redirect("~/login.aspx");
    //                }
    //            }
    //            else
    //            {
    //                // CHECK USER IS LOGGED IN OR NOT
    //                if (Session["empcd"] == null && Session["CRM_empcd"] == null)
    //                {
    //                    // If user has requested to forgot password then we allow to open this page.
    //                    if (!Context.Request.Url.AbsoluteUri.ToUpper().Contains("/GUI/ADMIN/FORGOTPASSWORD/")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/GUI/WARNING.ASPX")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/BLOCKIP.ASPX")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CUSTOMERLOGIN")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CONTROLTOWER")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CONTROLTOWERV2")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CONTROLTOWERV3")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CONTROLTOWERV4")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CLIENTS")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/TRACKING_NEW/WEBSITE")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/TRACKING_NEW/WEBSITE/TRACKCONSIGNMENT.ASPX")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/RESTSERVICE/")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/SERVICE/")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/SERVICES/")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/GUI/SERVICES/")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/WS_WEBX_GPS.ASMX")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/GPS_TRACK/")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/FDSM/")
    //                        && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CRM/LOGIN.ASPX")

    //                        )
    //                    {
    //                        //Check if request page is not login.page then only redirect to login page                 
    //                        if (!Context.Request.Url.AbsoluteUri.ToUpper().Contains("/GUI/DEFAULT.ASPX")
    //                            && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CUSTOMERLOGIN/GUI/LOGIN.ASPX")
    //                            && !Context.Request.Url.AbsoluteUri.ToUpper().Contains("/CRM/LOGIN.ASPX")
    //                            )
    //                        {
    //                            //If customer login then redirect to customer login page.
    //                            if (Context.Request.Url.AbsoluteUri.ToUpper().Contains("CUSTOMERLOGIN"))
    //                            {
    //                                Context.Response.Redirect("~/CustomerLogin/GUI/Login.aspx");
    //                            }
    //                            //else if (Context.Request.Url.AbsoluteUri.ToUpper().Contains("CRM/LOGIN.ASPX"))
    //                            //{
    //                            //    Context.Response.Redirect("~/CRM/Login.aspx");
    //                            //}
    //                            else
    //                            {
    //                                //redirect user login page
    //                                Context.Response.Redirect("~/GUI/default.aspx");
    //                            }
    //                        }
    //                    }
    //                }
    //                else
    //                {
    //                }
    //            }
    //        }
    //    }
    //}
</script>
