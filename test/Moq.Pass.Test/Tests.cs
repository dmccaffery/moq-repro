namespace Tests
{
    using Microsoft.Build.Framework;

    using Moq;
    using Xunit;

    public class Tests
    {
        [Fact]
        public void Test1()
        {
            var engine = new Mock<IBuildEngine4>();

            Assert.True(true);
        }
    }
}