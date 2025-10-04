using Microsoft.AspNetCore.Mvc;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/students")]
    public class StudentsController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetAll()
        {
            return Ok(new object[] { });
        }
    }
}


