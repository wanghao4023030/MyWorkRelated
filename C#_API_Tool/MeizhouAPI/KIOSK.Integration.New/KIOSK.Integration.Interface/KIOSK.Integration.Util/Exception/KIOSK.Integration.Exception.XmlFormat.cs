using System;
using System.Runtime.Serialization;

namespace KIOSK.Integration.Util
{
    /// <summary>
    /// The exception that is thrown when a user self-define error occurs.
    /// </summary>
    public class KIOSKIntegrationXmlFormatException : KIOSKIntegrationException
    {
        /// <summary>
        /// Initializes a new instance of the System.ApplicationException class.
        /// </summary>
        public KIOSKIntegrationXmlFormatException()
        { }

        /// <summary>
        /// Initializes a new instance of the System.ApplicationException class with 
        /// a specified error message.
        /// </summary>
        /// <param name="message">A message that describes the error.</param>
        public KIOSKIntegrationXmlFormatException(string message)
            : base(message)
        { }

        /// <summary>
        /// Initializes a new instance of the System.ApplicationException class with serialized data.
        /// </summary>
        /// <param name="info">The object that holds the serialized object data.</param>
        /// <param name="context">The contextual information about the source or destination.</param>
        protected KIOSKIntegrationXmlFormatException(SerializationInfo info, StreamingContext context)
            : base(info, context)
        { }

        /// <summary>
        /// Initializes a new instance of the System.ApplicationException class with 
        /// a specified error message and a reference to the inner exception that is 
        /// the cause of this exception.
        /// </summary>
        /// <param name="message">The error message that explains the reason for the exception.</param>
        /// <param name="innerException">
        /// The exception that is the cause of the current exception. If the innerException 
        /// parameter is not a null reference, the current exception is raised in a catch 
        /// block that handles the inner exception.
        /// </param>
        public KIOSKIntegrationXmlFormatException(string message, Exception innerException)
            : base(message, innerException)
        { }
    }
}