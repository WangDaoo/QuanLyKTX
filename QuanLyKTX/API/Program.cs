using BLL;
using DAL;
using DAL.Helper;
using Model;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddMemoryCache();

// Swagger configuration with JWT
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo 
    { 
        Title = "Quản Lý Ký Túc Xá API", 
        Version = "v1",
        Description = "API cho hệ thống quản lý ký túc xá"
    });
    
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "JWT Authorization header using the Bearer scheme. Example: \"Authorization: Bearer {token}\"",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });
    
    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            new string[] {}
        }
    });
});

// CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

// Register DAL services
builder.Services.AddTransient<IDatabaseHelper, DatabaseHelper>();
builder.Services.AddTransient<ISinhVienRepository, SinhVienRepository>();
builder.Services.AddTransient<IPhongRepository, PhongRepository>();
builder.Services.AddTransient<IToaNhaRepository, ToaNhaRepository>();
builder.Services.AddTransient<IHopDongRepository, HopDongRepository>();
builder.Services.AddTransient<IHoaDonRepository, HoaDonRepository>();
builder.Services.AddTransient<IGiuongRepository, GiuongRepository>();
builder.Services.AddTransient<ITaiKhoanRepository, TaiKhoanRepository>();

// Register BLL services
builder.Services.AddTransient<ISinhVienBusiness, SinhVienBusiness>();
builder.Services.AddTransient<IPhongBusiness, PhongBusiness>();
builder.Services.AddTransient<IToaNhaBusiness, ToaNhaBusiness>();
builder.Services.AddTransient<IHopDongBusiness, HopDongBusiness>();
builder.Services.AddTransient<IHoaDonBusiness, HoaDonBusiness>();
builder.Services.AddTransient<IGiuongBusiness, GiuongBusiness>();
builder.Services.AddTransient<ITaiKhoanBusiness, TaiKhoanBusiness>();

// JWT Authentication
var appSettingsSection = builder.Configuration.GetSection("AppSettings");
var appSettings = appSettingsSection.Get<AppSettings>() 
    ?? throw new InvalidOperationException("Missing AppSettings configuration.");
if (string.IsNullOrWhiteSpace(appSettings.Secret))
    throw new InvalidOperationException("AppSettings:Secret must be configured.");
var key = Encoding.ASCII.GetBytes(appSettings.Secret);

builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(x =>
{
    x.RequireHttpsMetadata = false;
    x.SaveToken = true;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(key),
        ValidateIssuer = true,
        ValidIssuer = appSettings.Issuer,
        ValidateAudience = true,
        ValidAudience = appSettings.Audience,
        ValidateLifetime = true,
        ClockSkew = TimeSpan.Zero
    };
});

var app = builder.Build();

// Configure the HTTP request pipeline
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Quản Lý Ký Túc Xá API v1");
        c.RoutePrefix = string.Empty; // Set Swagger UI at the app's root
    });
}

app.UseRouting();
app.UseCors("AllowAll");
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();

app.Run();