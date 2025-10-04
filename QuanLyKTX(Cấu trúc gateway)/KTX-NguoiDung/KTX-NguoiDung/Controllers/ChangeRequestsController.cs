using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Net.Http.Headers;

namespace KTX_NguoiDung.Controllers
{
    [ApiController]
    [Route("api/change-requests")] 
    [Authorize(Roles = "Student")]
    public class ChangeRequestsController : ControllerBase
    {
        private readonly IHttpClientFactory _httpFactory;
        public ChangeRequestsController(IHttpClientFactory httpFactory) { _httpFactory = httpFactory; }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] object body)
        {
            var token = Request.Headers["Authorization"].ToString();
            var client = _httpFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = AuthenticationHeaderValue.Parse(token);
            var res = await client.PostAsJsonAsync("http://localhost:5201/api/change-requests", body);
            var json = await res.Content.ReadAsStringAsync();
            return Content(json, "application/json");
        }
    }
}


