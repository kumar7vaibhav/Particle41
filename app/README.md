# Task 1
## Tiny App Development: 'SimpleTimeService'

Create a simple microservice (which we will call "SimpleTimeService") in any programming language of your choice: Go, NodeJS, Python, C#, Ruby, whatever you like.
The application should be a web server that returns a pure JSON response with the following structure, when its / URL path is accessed:
```JSON
{
  "timestamp": "<current date and time>",
  "ip": "<the IP address of the visitor>"
}
```
### Dockerize SimpleTimeService

Create a Dockerfile for this microservice.
Your application MUST be configured to run as a non-root user in the container.

### Build SimpleTimeService image

Publish the image to a public container registry (for example, DockerHub) so we can pull it for testing.

---

## Solution: Pull Docker image from Docker Hub
```bash
docker pull kumar7vaibhav/simpletimeservice
```

