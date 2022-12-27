version := "latest"

build-images:
	echo "Building images version: $(version)"
	docker build -t adhiana46/ms-node-client-react:$(version) ./client-react/
	docker build -t adhiana46/ms-node-comment-service:$(version) ./comments/
	docker build -t adhiana46/ms-node-event-bus:$(version) ./event-bus/
	docker build -t adhiana46/ms-node-moderation-service:$(version) ./moderation/
	docker build -t adhiana46/ms-node-post-service:$(version) ./posts/
	docker build -t adhiana46/ms-node-query-service:$(version) ./query/
	echo "Done building images."
push-images:
	echo "Pushing images version $(version) to docker hub"
	docker push adhiana46/ms-node-client-react:$(version)
	docker push adhiana46/ms-node-comment-service:$(version)
	docker push adhiana46/ms-node-event-bus:$(version)
	docker push adhiana46/ms-node-moderation-service:$(version)
	docker push adhiana46/ms-node-post-service:$(version)
	docker push adhiana46/ms-node-query-service:$(version)
	echo "Done pushing images."
k8s-apply:
	kubectl apply -f ./infra/k8s
k8s-delete:
	kubectl delete -f ./infra/k8s
k8s-rollout-restart:
	kubectl rollout restart deployment/client-react
	kubectl rollout restart deployment/comments
	kubectl rollout restart deployment/event-bus
	kubectl rollout restart deployment/moderation
	kubectl rollout restart deployment/posts
	kubectl rollout restart deployment/query
minikube-clean:
	minikube image rm docker.io/adhiana46/ms-node-client-react docker.io/adhiana46/ms-node-comment-service docker.io/adhiana46/ms-node-event-bus docker.io/adhiana46/ms-node-moderation-service docker.io/adhiana46/ms-node-post-service docker.io/adhiana46/ms-node-query-service