﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json;
using Song.Entities;
using Song.ServiceInterfaces;
using Song.ViewData.Attri;
using WeiSha.Common;
using System.Reflection;
using pili_sdk;

namespace Song.ViewData.Methods
{
    /// <summary>
    /// 直播
    /// </summary>
    public class Live : IViewAPI
    {
        /// <summary>
        /// 记录直播的各种设置项
        /// </summary>
        /// <param name="letter"></param>
        [HttpPost]
        public int Setup(Letter letter)
        {
            try
            {
                //记录key
                string akey = letter.GetParameter("AccessKey").String;
                string skey = letter.GetParameter("SecretKey").String;
                Business.Do<ILive>().SetupKey(akey, skey);
                //直播空间
                string space = letter.GetParameter("LiveSpace").String;
                Business.Do<ILive>().SetupLiveSpace(space);
                ////播放域名
                //string rtmp = letter.GetParameter("rtmp").String;
                //string hls = letter.GetParameter("hls").String;
                //string hdl = letter.GetParameter("hdl").String;
                //Business.Do<ILive>().SetupLive(rtmp, hls, hdl);
                ////推流域名
                //Business.Do<ILive>().SetupPublish(letter.GetParameter("Publish").String);

                //HDL直播播放域名，是否启用HTTPS
                Business.Do<ILive>().SetupProtocol(letter.GetParameter("Protocol").String);
                //直播截图的域名
                Business.Do<ILive>().SetupSnapshot(letter.GetParameter("Snapshot").String);
                //点播域名
                Business.Do<ILive>().SetupVod(letter.GetParameter("Vod").String);

                Business.Do<ISystemPara>().Refresh();
                Business.Do<ILive>().Initialization();
                return 1;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }        
        /// <summary>
        /// 获取设置项
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public Dictionary<string, string> GetSetup()
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            object obj = Business.Do<ILive>();
            Type type = obj.GetType();
            foreach (PropertyInfo pi in type.GetProperties())
            {
                if (pi.Name.StartsWith("Get"))
                {
                    string key = pi.Name.Substring(3);
                    object objResult = pi.GetValue(obj, null);
                    dic.Add(key, objResult == null ? "" : objResult.ToString());
                }
            }
            return dic;
        }
        /// <summary>
        /// 测试链接是否通过
        /// </summary>
        /// <returns></returns>
        public bool Test()
        {
            pili_sdk.pili.StreamList streams = null;
            try
            {
                streams = Business.Do<ILive>().StreamList(string.Empty, 10);
                return true;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
    }
}
