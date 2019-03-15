namespace KIOSK.Integration.Log
{
    /// <summary>
    /// Log system's base class.Defines methods for writing log.
    /// </summary>
    public abstract class LogBasic
    {
        /// </summary>
        /// <param name="logInfo">The message that describes the log.</param>
        public virtual void DebugLog(LogInfo logInfo)
        {
            WriteLog(logInfo);
        }

        /// <summary>
        /// Write a warning type's log message.
        /// </summary>
        /// <param name="logInfo">The message that describes the log.</param>
        public virtual void WarningLog(LogInfo logInfo)
        {
            WriteLog(logInfo);
        }

        /// <summary>
        /// Write a error type's log message.
        /// </summary>
        /// <param name="logInfo">The message that describes the log.</param>
        public virtual void ErrorLog(LogInfo logInfo)
        {
            WriteLog(logInfo);
        }

        /// <summary>
        /// Write a log message.
        /// </summary>
        /// <param name="logInfo">The message that describes the log.</param>
        protected abstract void WriteLog(LogInfo logInfo);
    }
}
